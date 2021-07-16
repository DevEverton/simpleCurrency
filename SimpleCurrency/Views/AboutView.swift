//
//  AboutView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 14/07/21.
//

import SwiftUI



struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            VStack(alignment: .leading, spacing: 5.0) {
                HStack {
                    Image(systemName: "lightbulb.fill").font(.system(size: 16, weight: .bold))
                        .foregroundColor(.yellow)
                    
                    Text("Motivation")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                }
                Text("The main goal of this app was to build an ad free experience and to make it easy to convert your currency without any interruption. The app is completely free and will not be monetized.")
            }
            
            VStack(alignment: .leading, spacing: 5.0) {
                HStack {
                    Image(systemName: "person.fill").font(.system(size: 16, weight: .bold))
                        .foregroundColor(.blue)
                    
                    Text("Meet the Dev")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                }
                
                Text("Hello, my name is Everton and I'm an indie developer located in Brazil. If you want support my work follow me on Twiter and Instagram. Any feedback on your experience using the app would be apreciated!")
            }
            
            
            VStack(alignment: .leading, spacing: 5.0) {
                HStack {
                    Image(systemName: "rectangle.3.offgrid.bubble.left").font(.system(size: 16, weight: .regular))
                        .foregroundColor(.green)
                    
                    Text("Contact Me")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                }
                VStack(alignment: .leading, spacing: 5.0) {
                    Link("Twitter", destination: URL(string: "https://twitter.com/everton_dev")!)
                    Link("Instagram", destination: URL(string: "https://www.instagram.com/everton_iosdev")!)
                }
                .foregroundColor(.blue)
                
            }
            Spacer()
        }
        .padding()
        .padding(.top)
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
