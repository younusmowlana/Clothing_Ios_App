//
//  Splashview.swift
//  ios-clothing-app
//
//  Created by Kabir Moulana on 3/10/24.
//

import SwiftUI

struct Splashview: View {
    @State var isActive = false
    
    var body: some View {
       
        VStack{
            if isActive {
                OnBoardingView()
            }else {
                Text("Nike")
                    .font(.largeTitle.bold())
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                withAnimation{
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    Splashview()
}