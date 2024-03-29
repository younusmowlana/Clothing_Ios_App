//
//  ImageSlider.swift
//  ios-clothing-app
//
//  Created by Kabir Moulana on 3/29/24.
//

import SwiftUI

struct ImageSlider: View {
    
    var images: [String]
    
    var body: some View {
        TabView{
            ForEach(images, id: \.self){img in
                AsyncImage(url: URL (string: img )){ Image in
                    Image.resizable()
                        .scaledToFill()
                }placeholder: {
                    ProgressView()
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        
    }
}


