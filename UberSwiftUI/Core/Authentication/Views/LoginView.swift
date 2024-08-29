import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image("uber-app-icon")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("UBER")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                
                VStack(spacing: 32) {
                    CustomInputField(text: $email, title: "Email address", placeholder: "name@example.com")
                    CustomInputField(text: $password, title: "Password", placeholder: "Enter password", isSecureField: true)
                    Button {} label: {
                        Text("Forgot password")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.top)
                    }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                    
                }.padding(.top, 12).padding(.horizontal)
                
                
                VStack {
                    HStack(spacing: 24) {
                        Rectangle().frame(width: 76, height: 1).foregroundColor(.white).opacity(0.5)
                        Text("Sign in with social").foregroundColor(.white)
                            .fontWeight(.semibold)
                        Rectangle().frame(width: 76, height: 1).foregroundColor(.white).opacity(0.5)
                    }
                    HStack(spacing: 25) {
                        Button {
                            
                        } label: {
                            Image("facebook-sign-in-icon")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        Button {
                            
                        } label: {
                            Image("google-sign-in-icon")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                }.padding(.vertical)
                
                Spacer()
                
                Button(action: {}, label: {
                    HStack {
                        Text("SIGN IN").foregroundColor(.black)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                    }
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                })
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .font(.system(size: 14))
                        Text("Sign up")
                            .font(.system(size: 14, weight: .semibold))
                    }.foregroundColor(.white)
                }

                

            }.padding(.top, 60)
        }
    }
}

#Preview {
    LoginView()
}
