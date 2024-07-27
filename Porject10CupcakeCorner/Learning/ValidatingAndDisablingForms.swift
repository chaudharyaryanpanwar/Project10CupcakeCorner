//
//  ValidatingAndDisablingForms.swift
//  Porject10CupcakeCorner
//
//  Created by Aryan Panwar on 18/06/24.
//

import SwiftUI

struct ValidatingAndDisablingForms: View {
    @State private var username = ""
    @State private var email = ""
    var disableForm : Bool {
        username.count < 5 || email.count < 5
    }
    var body: some View {
        Form {
            Section {
                TextField("Username" , text : $username)
                TextField("Email" , text : $email)
            }
            
            Section {
                Button("Create Account"){
                    print("Creating Account.......")
                }
            }
//            .disabled(username.isEmpty || email.isEmpty)
            .disabled(disableForm)
        }
    }
}

#Preview {
    ValidatingAndDisablingForms()
}
