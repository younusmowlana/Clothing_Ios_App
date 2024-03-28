//
//  Home.swift
//  ios-clothing-app
//

//

import SwiftUI

struct Home: View {
    @StateObject var productModel = ProductViewModel()
    
    @State var searchTerm = ""
    
    @State var currentCategory = "All"

    var body: some View {
        NavigationStack {
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
                
                ZStack {
                    TextField("Search cloths", text: $searchTerm)
                        .padding(.horizontal)
                        .frame(height: 60 )
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())
                        .overlay{
                            Capsule()
                                .stroke(.white.opacity(0.8), lineWidth: 0.5 )
                        }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)

                catergoriesView
                    .zIndex(1)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(filteredProducts, id: \.id) { item in
                            ProductItemView(product: item)
                        }
                    }
                    .padding(.top, 10)
                }
                .scrollIndicators(.hidden)
                .onAppear {
                    productModel.loadDataCombine()
                }
            }
        }
    }
    
    var filteredProducts: [ProductModel] {
        let searchedProducts: [ProductModel]
        if searchTerm.isEmpty {
            searchedProducts = productModel.products
        } else {
            searchedProducts = productModel.products.filter { $0.title.localizedCaseInsensitiveContains(searchTerm) }
        }
        
        if currentCategory == "All" {
            return searchedProducts
        } else {
            return searchedProducts.filter {
                
                $0.categories.contains(currentCategory)
            }
        }
    }


    
    var catergoriesView : some View {
        ScrollView(.horizontal){
            HStack(spacing:15,content: {
                Spacer()
                ForEach(sampleCategory, id: \.id) {item in
                    HStack{
                        if !item.title.isEmpty{
                            Text(item.title)
                                .scaledToFit()
                        }
 
                    }
                    .foregroundStyle(currentCategory == item.title ? .white : .black)
                    .padding()
                    .background(currentCategory == item.title ? .black : .gray.opacity(0.08))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation{
                            currentCategory = item.title
                        }
                        
                    }
                }
            })
        }
        .scrollIndicators(.hidden)
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
