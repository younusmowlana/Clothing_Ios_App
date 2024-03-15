//
//  Sign-up.swift
//  ios-clothing-app
//
//

import SwiftUI

struct Sign_up: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userName = ""
    @State private var alertMessage = ""
    
    @Environment(\.presentationMode) var dismiss
    
    @State private var showAlert = false
    @StateObject var userViewModel = UserViewModel()
    @State private var isLoading = false
    @State private var isSigined = false
    
    var body: some View {
        NavigationStack{
            
            
            VStack (alignment: .leading,spacing: 40, content: {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss.wrappedValue.dismiss()
                    }
                
                VStack(spacing: 15 , content: {
                    Text("Sign-up")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    Text("Enter Your Email Address and Passord and continue shoping.")
                        .font(.callout )
                    
                })
                
                VStack(spacing: 15 , content: {
                    TextField("UserName", text: $userName)
                        .padding(.horizontal)
                        .frame(height: 60 )
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())
                        .overlay{
                            Capsule()
                                .stroke(.gray.opacity(0.8), lineWidth: 0.5 )
                        }
                    TextField("Email Address", text: $email)
                        .padding(.horizontal)
                        .frame(height: 60 )
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())
                        .overlay{
                            Capsule()
                                .stroke(.gray.opacity(0.8), lineWidth: 0.5 )
                        }
                    SecureField("Password", text: $password)
                        .padding(.horizontal)
                        .frame(height: 60 )
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())
                        .overlay{
                            Capsule()
                                .stroke(.gray.opacity(0.8), lineWidth: 0.5 )
                        }
                })
                
                Spacer()
                
                VStack(spacing: 15 , content: {
                    Button(action: {
                            isLoading = true
                            userViewModel.registerUser(username: userName, email: email, password: password) { result in
                                switch result {
                                case .success(let user):
                                    UserDefaults.standard.setValue(user.id, forKey: "UID")
                                    UserDefaults.standard.setValue(email, forKey: "Email")
                                    UserDefaults.standard.setValue(userName, forKey: "Name")
                                    print(user.id)
                                    isSigined = true
                                    alertMessage = "You have registerd successfully!"
                                    showAlert = true
                                case .failure(let error):
                                    withAnimation {
                                        isLoading.toggle()
                                    }
                                    print("Failed to register user: \(error.localizedDescription)")
                                    alertMessage = "Something went wrong. Please try to register within some times"
                                    showAlert = true
                                }
                            }
                        }) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Continue")
                            .fontWeight(.semibold)
                    }
                }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: 60)
                    .background(.red)
                    .clipShape(Capsule())
                    .foregroundStyle(.white)
//                    .navigationDestination(isPresented: $isSigined){
//                        ContentView()
//                    }
                    NavigationLink(destination: ContentView(), isActive: $isSigined) {
                           EmptyView()
                       }

                    
                    NavigationLink{
                        Sign_in()
                    }label: {
                        Text("Already having an Account? **Sign-in**")
                               .frame(maxWidth: .infinity)
                               
                            
                    }
                    
                    .foregroundColor(.black)
                })
                
            })
            .padding()
//            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Registration"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    isLoading = false
                }
            )
        }
    }
}

#Preview {
    Sign_up()
}
