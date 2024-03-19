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
                        
                        Image(systemName: "bell")
                            .padding(.vertical, 25)
                            .padding(.horizontal, 16)
                            .imageScale(.large)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.05), lineWidth: 3)
                            }
                    }
                    .padding()
                    
                    ForEach(productModel.products, id: \.id) { item in
                        ProductItemView(product: item)
                    }

                }
                
            }
            .scrollIndicators(.hidden)
            .onAppear {
                productModel.loadDataCombine()
            }
        }
    }
}

struct ProductItemView: View {
    @State var showProduct = false
    var product: ProductModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.img)) { img in
                img.resizable()
                    .scaledToFill()
                    .frame(height: 300)
            } placeholder: {
                ProgressView()
                    .frame(height: 300)
            }
            .clipShape(Rectangle())
            .frame(height: 300)
            
            Text(product.title)
                .font(.headline.bold())
                .multilineTextAlignment(.center)
            
            Text("$\(product.price)")
                .font(.callout)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.horizontal)
        .onTapGesture {
            showProduct = true
        }
        .sheet(isPresented: $showProduct) {
            ProductView(data: product)
        }
    }
}

#Preview {
    ContentView()
}

//AsyncImage(url: URL(string: product.img)) { img in
