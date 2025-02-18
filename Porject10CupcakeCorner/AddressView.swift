//
//  AddressView.swift
//  Porject10CupcakeCorner
//
//  Created by Aryan Panwar on 14/07/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order : Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address" , text : $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("ZIP", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check out"){
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
    }
    
    
}

#Preview {
    AddressView(order : Order())
}
