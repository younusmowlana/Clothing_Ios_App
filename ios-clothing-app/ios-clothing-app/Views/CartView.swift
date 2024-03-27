//
//  CartView.swift
//  ios-clothing-app
//
//

import SwiftUI

struct CartView: View {
    
    @StateObject var cartView: CartViewModel = CartViewModel()
    @State private var isLoading = true

    var totalAmount: Int {
        cartView.products.reduce(0) { $0 + $1.price * $1.quantity }
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(cartView.products, id: \.id) { item in
                    CartCard(product: item, cartView: cartView)
                    }
                }
                .padding(.top, 10)             }
            .scrollIndicators(.hidden)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Total Amount: $\(totalAmount)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                    }

                    Button("Purchase") {
                        // Handle purchase action
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.black)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(25)
                    .padding()
                }
            }
        
        .onAppear {
            cartView.getCartData()
        }
    }
}


struct CartCard: View {
    var product: CartModel
    @ObservedObject var cartView: CartViewModel

    @State private var isDeleted = false

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.img)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
            }
            .scaledToFill()
            .frame(width: 150, height: 150)
            .cornerRadius(10)
            .padding(.trailing, 8)

            VStack(alignment: .leading) {
                Text(product.title)
                    .bold()
                Text("Price: $\(product.price)")
                    .bold()
                    .frame(maxWidth:.infinity,alignment: .leading)
                
                Text("Size: \(product.size)")
                    .bold()
                    .frame(maxWidth:.infinity,alignment: .leading)
                HStack {
                    Button(action: {
                        // Handle decrease quantity
                    }) {
                        Image(systemName: "minus.circle")
                            .font(.title2)
                    }

                    Text("\(product.quantity)")
                        .font(.title2)

                    Button(action: {
                        // Handle increase quantity
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                    }
                    
                    Button(action: {
                        withAnimation {
                            isDeleted = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            cartView.deleteCart(id: product.id)
                        }
                    }) {
                        Image(systemName: "trash")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                    .animation(.default, value: isDeleted)
                }
                .padding(.top, 4)
            }
            
            Spacer()
        }
        .padding(16)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 6)
    }
}


#Preview {
    ContentView()
}
