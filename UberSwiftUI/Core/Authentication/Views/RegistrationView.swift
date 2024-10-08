import SwiftUI

struct RegistrationView: View {
    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .padding()
                }
                Text("Create new account")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250)
                Spacer()
                
                VStack {
                    VStack(spacing: 56) {
                        CustomInputField(text: $fullname, title: "Full name", placeholder: "Enter your name")
                        CustomInputField(text: $email, title: "Email address", placeholder: "name@example.com")
                        CustomInputField(text: $password, title: "Create password", placeholder: "Enter your password", isSecureField: true)
                    }.padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.registerUser(withEmail: email, password: password, fullname: fullname)
                    }, label: {
                        HStack {
                            Text("SIGN UP").foregroundColor(.black)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                    })
                    
                }

            }.foregroundColor(.white)
        }
    }
}

#Preview {
    RegistrationView()
}
