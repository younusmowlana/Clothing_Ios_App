//
//  CartView.swift
//  ios-clothing-app
//
//

import SwiftUI

struct CartView: View {
    @State var totalAmount: Int = 0
    
    
    @StateObject var cartView : CartViewModel = CartViewModel()

    var body: some View {
        VStack {
            List {
                ForEach(cartView.products, id: \.id) { item in
                    cartCard(product: item)
                }
            }
            
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
//        .onAppear {
//                    cartView.getCartData ()
//                }
            }

    }

struct cartCard: View {
    var product: CartModel
    
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
                        
                    }) {
                        Image(systemName: "minus.circle")
                            .font(.title2)
                    }

                    Text("\(product.quantity)")
                        .font(.title2)
                    

                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                    }
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
