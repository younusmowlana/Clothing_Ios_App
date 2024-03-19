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
            VStack(spacing: 0) {
                ZStack {
                    Color.white
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 60)
                    
                    HStack {
                        Text("**VOGUE's** Exclusive Gallery")
                            .font(.title)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Spacer()
                        
                        Image(systemName: "bell")
                            .padding(.vertical, 15)
                            .padding(.horizontal, 12)
                            .imageScale(.large)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black.opacity(0.1), lineWidth: 3)
                            }
                            .padding(.trailing, 20)
                    }
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(productModel.products, id: \.id) { item in
                            ProductItemView(product: item)
                        }
                    }
                    .padding(.top, 10) // Reduced top padding
                }
                .scrollIndicators(.hidden)
                .onAppear {
                    productModel.loadDataCombine()
                }
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
                ZStack {
                    Color.gray.opacity(0.1)
                    ProgressView()
                }
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
