//
//  Home.swift
//  ios-clothing-app
//

//

import SwiftUI

struct Home: View {
    @StateObject var productModel = ProductViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("**Gentleman's**\nGallery")
                            .font(.largeTitle)
                        
                        Spacer()
                        
                        Image(systemName: "bell")                             .padding(.vertical, 25)
                            .padding(.horizontal, 16)
                            .imageScale(.large)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.05), lineWidth: 3)
                            }
                    } 
                    .padding()
                    
                    prodView(productModel: productModel)
                }
                
            }
            .scrollIndicators(.hidden)
        }
        .onAppear {
            productModel.loadDataCombine()
        }
    }
}

func prodView(productModel: ProductViewModel) -> some View {
    VStack {
        Spacer()
        ForEach(productModel.products, id: \.id) { item in
            VStack {
                AsyncImage(url: URL(string: item.img)) { img in
                    img.resizable()
                        .scaledToFill()
                        .frame(height: 300)
                } placeholder: {
                    ProgressView()
                        .frame(height: 300)
                }
                .clipShape(Rectangle())
                .frame(height: 300)
                
                Text(item.title)
                    .font(.headline.bold())
                    .multilineTextAlignment(.center)
                
                Text("$\(item.price)")
                    .font(.callout)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding(.horizontal)
        }
        Spacer()
    }
    .zIndex(0)
    .padding(.horizontal)
}




#Preview {
    ContentView()
}

//AsyncImage(url: URL(string: product.img)) { img in