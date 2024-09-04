//
//  EfeDemir.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/4/24.
//

import SwiftUI

struct EfeDemir: View {
    var body: some View {
        VStack {
            Image("EfeDemir")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 300)
            Text("Hello, World!")
                .padding()
                .font(.headline)
            Text("Thank you for downloading YGO Search!")
                .padding(.horizontal)
                .font(.subheadline)
            
            Text("If you have any recommendations for improving the app, feel free to contact me :)")
                .padding(.horizontal)
                .font(.subheadline)
            
            VStack {
                Link(destination: URL(string: "https://www.linkedin.com/in/efekdemir/")!) {
                    Text("Connect on LinkedIn")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 20)

                Link(destination: URL(string: "https://github.com/efekdemir")!) {
                    Text("Visit my GitHub")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
            }
        }
    }
}


#Preview {
    EfeDemir()
}
