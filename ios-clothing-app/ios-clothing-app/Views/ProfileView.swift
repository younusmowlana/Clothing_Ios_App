//
//  ProfileView.swift
//  ios-clothing-app
//
//  Created by Kabir Moulana on 3/27/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userName = ""
    @State private var alertMessage = ""
    
    @Environment(\.presentationMode) var dismiss
    
    @State private var showAlert = false
    @StateObject var userViewModel = UserViewModel()
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack{
            VStack (alignment: .leading,spacing: 40, content: {
                VStack(spacing: 15 , content: {
                    let name = UserDefaults.standard.string(forKey: "Name")
                                        Text("**VOGUE's** Pvt Ltd.")
                                            .font(.title)
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            
                    
                    Text("Hello \(name ?? "") Your Profile Information")
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
                            .disabled(true)

                        TextField("Email Address", text: $email)
                            .padding(.horizontal)
                            .frame(height: 60 )
                            .background(.gray.opacity(0.2))
                            .clipShape(Capsule())
                            .overlay{
                                Capsule()
                                    .stroke(.gray.opacity(0.8), lineWidth: 0.5 )
                            }
                            .disabled(true)

                    
                })
                
                Spacer()
                
                
                
            })
            .padding()
            .onReceive(userViewModel.$userDetails) { userDetails in
                if let userDetails = userDetails.first {
                    email = userDetails.email!
                    userName = userDetails.username!
                }
            }
            .onAppear(){
                userViewModel.getUserData()
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Your Profile Status"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    isLoading = false
                }
            )
        }
    }
}

#Preview {
    ContentView()
}
