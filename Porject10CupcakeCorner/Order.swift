//
//  Order.swift
//  Porject10CupcakeCorner
//
//  Created by Aryan Panwar on 18/06/24.
//

import Foundation

@Observable
class Order  : Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    init(type: Int = 0, quantity: Int = 3, specialRequestEnabled: Bool = false, extraFrosting: Bool = false, addSprinkles: Bool = false, name: String = "", streetAddress: String = "", city: String = "", zip: String = "") {
        self.type = type
        self.quantity = quantity
        self.specialRequestEnabled = specialRequestEnabled
        self.extraFrosting = extraFrosting
        self.addSprinkles = addSprinkles
        self.name = name
        self.streetAddress = streetAddress
        self.city = city
        self.zip = zip
    }
    static let types = ["Vanilla" , "Strawberry" , "Chocolate" , "Rainbow" ]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress : Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    var cost : Decimal  {
        var cost  = Decimal(quantity) * 2
        
        cost += Decimal(type)/2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity)/2
        }
        
        return cost 
    }
    
    
}

func saveToUserDefaults(_ order : Order){
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(order) {
        UserDefaults.standard.set(encoded , forKey: "userOrder")
    }
}

func loadFromUserDefaults() -> Order? {
    if let data = UserDefaults.standard.data(forKey: "userOrder"){
        let decoder = JSONDecoder()
        if let userOrder = try? decoder.decode(Order.self, from: data){
            return Order(type: userOrder.type, quantity: userOrder.quantity, specialRequestEnabled : userOrder.specialRequestEnabled, extraFrosting : userOrder.extraFrosting , addSprinkles: userOrder.addSprinkles, name: userOrder.name , streetAddress:userOrder.streetAddress ,  city: userOrder.city , zip: userOrder.zip)
        }
    }
    return nil
}
