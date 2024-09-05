import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func registerUser(withEmail email: String, password: String, fullname: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to create a new user \(error.localizedDescription)")
                return
            } else {
                self.userSession = result?.user
                guard let firebaseUser = result?.user else { return }
                let user = User(fullname: fullname, email: email, uid: firebaseUser.uid)
                guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
                Firestore.firestore().collection("users").document(firebaseUser.uid).setData(encodedUser)
            }
        }
    }
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to signin user - \(error)")
                return
            } else {
                self.userSession = result?.user
            }
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print("Error while signing out - \(error)")
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        print("uid: \(uid)")
        Firestore.firestore().collection("users").document(uid).getDocument { result, error in
            if let error = error {
                print("Could not retrieve user from db \(error)")
                return
            } else {
                guard let snapshot = result else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                self.currentUser = user
                print("User: \(user)")
            }
        }
    }
}
