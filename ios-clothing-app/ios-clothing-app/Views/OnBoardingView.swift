//
//  OnBoardingView.swift
//  ios-clothing-app
//
//

import SwiftUI

struct OnBoardingView: View {
    
    @State private var isActive = false
    
    @State private var isExpanded = false
    
    @State private var offset = CGSize.zero
    var body: some View {
        if isActive {
            Sign_in()
        }
        else{
            ZStack(alignment: .top){
                VStack{
                    Spacer()
                    Circle()
                        .fill(
                            RadialGradient(colors: [.black, .clear, .clear, .clear], center: .center, startRadius: 0, endRadius: UIScreen.main.bounds.width)
                        )
                        .scaleEffect(isExpanded ? 20 : 2)
                        .padding(.bottom,-(UIScreen.main.bounds.width / 2))
                }
                .frame(height: .infinity)
                .zIndex(isExpanded ? 2 : 0)
                VStack(spacing: 15, content: {
                     Spacer()
                    
//                    Image("nike_oboarding")
//                        .resizable()
//                        .scaledToFill()
                    Text("Start journy\nwith Vogue™")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    Text("Smart gorgeous and fashionable collection make you cool.")
                        .multilineTextAlignment(.center)
                        .opacity(0.6)
                        .foregroundColor(.white)
                    
                    
                    VStack{
                        
                        Image(systemName: "chevron.up")
                        Text("Get Started")
                            .padding(.top)
                        
                    }
                    .fontWeight(.medium)
                })
                .opacity(isExpanded ? 0 : 1)
                .offset(offset)
            }

            //swipe up gasture
            .gesture(DragGesture()
                .onEnded({value in
                    if value.translation.height < 50 {
                        withAnimation(.easeInOut(duration: 2)){
                            offset = value.translation
                            isExpanded = true
                        }
                        
                        //after swipe up move to next screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                            withAnimation{
                                isActive.toggle()
                            }
                        }
                    }
                }))
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity )
            .background(
              Image("vogue_oboarding")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            )
//            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
        
    }
}

#Preview {
    OnBoardingView()
}
