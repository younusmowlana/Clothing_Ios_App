//
//  Sign-up.swift
//  ios-clothing-app
//
//  Created by Kabir Moulana on 3/10/24.
//

import SwiftUI

struct Sign_up: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userName = ""
    
    
    @Environment(\.presentationMode) var dismiss
    
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
                
                //login button
                VStack(spacing: 15 , content: {
                    Button{
                        
                    }label: {
                        Text("Continue")
                            .fontWeight(.semibold )
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: 60)
                    .background(.red)
                    .clipShape(Capsule())
                    .foregroundStyle(.white)
                    
                    NavigationLink{
                        Sign_in()
                    }label: {
                        Text("Already having an Account? **Sign-in**")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    
                    .foregroundColor(.white)
                })
                
            })
            .padding()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    Sign_up()
}
