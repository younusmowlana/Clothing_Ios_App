//
//  CartView.swift
//  ios-clothing-app
//
//

import SwiftUI

struct CartView: View {
    var body: some View {
        VStack{
            HStack(){
                Button(action: {}){
                    Image(systemName: "cheron.left")
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundColor(.black)
                }
                Text("My Cart") 
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                
            }
        }
    }
}

#Preview {
    ContentView()
}
