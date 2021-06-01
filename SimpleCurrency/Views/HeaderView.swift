//
//  HeaderView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/06/21.
//

import SwiftUI

struct HeaderView: View {
    
    @State var lastUpdated = "01/01/2001"
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text("sCurrency")
                    .font(.system(size: 30, weight: .black, design: .default))
                .foregroundColor(Color("title"))
            Spacer()
            Text("Updated on \(lastUpdated)")
                .font(.system(size: 12, weight: .light, design: .default))
            Button(action: {
                //TODO: - Update the date value and call the API again
                
            }, label: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color("Purple1"))
            })
        }
        .padding(10)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)

            
    }
}
