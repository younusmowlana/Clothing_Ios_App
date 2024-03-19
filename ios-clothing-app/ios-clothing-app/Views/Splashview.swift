//
//  Splashview.swift
//  ios-clothing-app
//
//

import SwiftUI

struct Splashview: View {
    @State var isActive = false
    
    var body: some View {
       
        VStack{
            if isActive {
                OnBoardingView()
            }else {
                Text("Vogue")
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
        .preferredColorScheme(.light)
    }
}

#Preview {
    Splashview()
}
