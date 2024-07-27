//
//  LoadingAnImageFromARemoteServer.swift
//  Porject10CupcakeCorner
//
//  Created by Aryan Panwar on 18/06/24.
//

import SwiftUI

struct LoadingAnImageFromARemoteServer: View {
    var body: some View {
//        AsyncImage(url: URL(string : "https://hws.dev/img/logo.png") , scale : 3)
//        
//        THESE PROPERTIES WOULD NOT WORK BECAUSE THEY CAN ONLY BE APPLITED TO NORMAL IMAGE
//            .resizable()
//            .frame(width : 200 , height : 200)
        
        AsyncImage(url: URL(string : "https://hws.dev/img/logo.png")){ image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
//            Color.red
            ProgressView()
        }
        .frame(width : 200 , height : 200)
        
    }
}

struct LoadingAnImageFromARemoteServer2: View {
    var body: some View {
        AsyncImage(url: URL(string : "https://hws.dev/img/logo.png") , scale : 3){ phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width : 200 , height : 200)
    }
}

#Preview {
    LoadingAnImageFromARemoteServer2()
}
