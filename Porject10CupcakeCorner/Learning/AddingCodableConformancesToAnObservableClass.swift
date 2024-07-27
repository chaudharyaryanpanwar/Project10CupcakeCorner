//
//  AddingCodableConformancesToAnObservableClass.swift
//  Porject10CupcakeCorner
//
//  Created by Aryan Panwar on 18/06/24.
//

import SwiftUI

@Observable
class User : Codable {
    enum CodingKeys : String , CodingKey {
        case _name = "name"
    }
    var name = "Taylor"
}

struct AddingCodableConformancesToAnObservableClass: View {
    var body: some View {
        Button("Encode Taylor" , action : encodeTaylor)
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding : data , as : UTF8.self)
        print(str)
    }
}

#Preview {
    AddingCodableConformancesToAnObservableClass()
}
