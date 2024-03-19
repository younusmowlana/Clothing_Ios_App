//
//  Sign-in.swift
//  ios-clothing-app
//

import SwiftUI

struct Sign_in: View {
    @State private var username = ""
    @State private var password = ""
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var dismiss
    
    @State private var showAlert = false
    @StateObject var userViewModel = UserViewModel()
    @State private var isLoading = false
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack{
            
            VStack (alignment: .leading,spacing: 40, content: {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss.wrappedValue.dismiss()
                    }
                
                VStack(spacing: 15 , content: {
                    Text("Sign-in")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    Text("Enter Your Email Address and Passord and continue shoping.")
                        .font(.callout )
                    
                })
                
                VStack(spacing: 15 , content: {
                    TextField("UserName", text: $username)
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
                
                //login button
                VStack(spacing: 15 , content: {
                    
                    
                    Button(action: {
                        isLoading = true
                    userViewModel.loginUser(username: username, password: password ){ result in
                        switch result {
                        case .success(let user):
                            UserDefaults.standard.setValue(user.id, forKey: "UID")
                            UserDefaults.standard.setValue(username, forKey: "Name")
                            print(user.id)
                            isLoggedIn.toggle()
                        case .failure(let error):
                            withAnimation{
                                isLoading.toggle()
                            }
                            print("Failed to register user: \(error.localizedDescription)")
                            alertMessage = "Something went wrong. Please try to logIn within some times"
                            showAlert = true
                            print("Failed to register user: \(error)")

                        }
                        isLoading = false
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
                    NavigationLink(destination: ContentView(), isActive: $isLoggedIn) {
                           EmptyView()
                       }
                    
                    NavigationLink{
                        Sign_up()
                    }label: {
                        Text("Not having account? **Sign-up**")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
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
                title: Text("Sign in"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    isLoading = false
                }
            )
        }

    }
}

#Preview {
    Sign_in()
}
