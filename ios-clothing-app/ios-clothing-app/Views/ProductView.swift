
import SwiftUI

struct ProductView: View {
    var data: ProductModel
    
    @State var selectedSize = "XL"
    
    @StateObject var cartViewModel = CartViewModel()
    
    @Environment(\.presentationMode) var dismiss
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    ZStack(alignment: .top){
                        AsyncImage(url: URL(string: data.img)) { img in
                            img.resizable()
                                .scaledToFill()
                                .frame(height: 400)
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                                .padding(10 )
                        } placeholder: {
                            ProgressView()
                                .frame(height: 300)
                        }
                        
                        //Navigation
                        HStack{
                            Image(systemName: "arrow.left")
                                .onTapGesture {
                                    dismiss.wrappedValue.dismiss()
                                }
                            Spacer()
                            
                            Image(systemName: "heart")
                        }
                        .padding(.top, safeArea().top)
                        .padding(.horizontal,30)
                        .imageScale(.large)
                    }
                    
                    Text(data.title)
                        .font(.largeTitle.bold())
                    
                    Text("$\(data.price)")
                        .font(.title.bold())
                    
                    
                    VStack(alignment: .leading, content: {
                        Text("Sizes")
                            .font(.title2.bold())
                        
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(data.size, id: \.self) {item in
                                    Text("\(item)")
                                        .font(.headline)
                                        .frame(width: 70, height: 70)
                                        .background(selectedSize == item ? .black: .gray.opacity(0.06))
                                        .foregroundStyle(selectedSize == item ? .white : .black)
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                    
                                        .onTapGesture {
                                            selectedSize =  item
                                        }
                                    
                                    
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    })
                    .padding()
                    
                    VStack(alignment:.leading , spacing: 20){
                        Text("Details")
                            .font(.title2.bold())
                        
                        Text(data.desc)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                }
            }
            
            //button bar
            HStack{
                //Price
                VStack(alignment:.leading ){
                    Text("$\(data.price)")
                        .font(.title2.bold())
                    
                }
                .frame(width: UIScreen.main.bounds.width / 2.5, height: 60 )
                .background(.gray.opacity(0.06))
                .clipShape(.rect(cornerRadius: 25))
                
                
                
                
                // Add to Cart
                Button("Add to Cart") {
                    if let userID = UserDefaults.standard.string(forKey: "UID") {
                        cartViewModel.createCart(userID: userID, productID: data.id, size: selectedSize) { result in
                            switch result {
                            case .success(let cartModel):
                                print("Cart created successfully: \(cartModel)")
                            case .failure(let error):
                                print("Failed to create cart: \(error)")
                            }
                        }
                    } else {
                        print("Failed to retrieve userID from UserDefaults")
                    }
                }


                .frame(maxWidth:.infinity)
                .frame(height: 60)
                .background(.black)
                .clipShape(.rect(cornerRadius: 25))
                .foregroundStyle(.white)
                .fontWeight(.semibold)
            }
            .padding(.horizontal)
        }
        .edgesIgnoringSafeArea(.top)
        .ignoresSafeArea()
        .scrollIndicators(.hidden)
        .navigationBarHidden(true)
    }
       
    
}

extension View{
    func safeArea() -> UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}
