//
//  EfeDemir.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/4/24.
//

import SwiftUI
import AnimatedGradient

struct EfeDemir: View {
    var body: some View {
        ZStack {
            AnimatedLinearGradient(colors: [.blue, .white])
                .numberOfSimultaneousColors(3)
                .setAnimation(.linear(duration: 2))
                .gradientPoints(start: .bottomLeading, end: .topTrailing)
            VStack {
                Image("EfeDemir")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 300)
                
                Text("Hello, World!")
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .glowBorder(color: .black, lineWidth: 3)
                
                Text("Thank you for downloading YGO Search!")
                    .padding(.horizontal)
                    .padding(.bottom)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .glowBorder(color: .black, lineWidth: 2)
                
                Text("If you have any recommendations for improving the app, feel free to contact me :)")
                    .padding(.horizontal)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .glowBorder(color: .black, lineWidth: 2)
                
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
}
