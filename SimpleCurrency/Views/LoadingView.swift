//
//  LoadingView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 14/06/21.
//

import SwiftUI

struct LoadingView: View {
        
    var body: some View {
        ZStack {
            Color(CGColor(gray: 0.4, alpha: 1.0))
            VStack {
                ProgressView()
                    .padding(.bottom, 2)
                Text("Loading...")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            .frame(width: 130, height: 100, alignment: .center)
            .background(Color.white)
            .cornerRadius(20)
            
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
