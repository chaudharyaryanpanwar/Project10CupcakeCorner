//
//  AddressView.swift
//  Porject10CupcakeCorner
//
//  Created by Aryan Panwar on 18/06/24.
//

import SwiftUI

struct CheckoutView: View {
    
    var order : Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var errorMessage = ""
    @State private var isShowingErrorMessage = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string : "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){ image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height : 233)
                
                Text("Your total is \(order.cost , format : .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order"){
                    saveToUserDefaults(order)
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert( "Thank You", isPresented: $showingConfirmation) {
            Button("OK"){}
        } message : {
            Text(confirmationMessage)
        }
        .alert("Oops", isPresented: $isShowingErrorMessage) {
            Button("Try Again"){
                Task {
                    await placeOrder()
                }
            }
        } message: {
            Text(errorMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return 
        }
        
        let url = URL(string : "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url : url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data , _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            
            showingConfirmation = true
        } catch {
            print("Checkout Failed :\(error.localizedDescription)")
            isShowingErrorMessage = true
            errorMessage = "No Network Connection"
            
        }
    }
}

#Preview {
    CheckoutView(order : Order())
}
