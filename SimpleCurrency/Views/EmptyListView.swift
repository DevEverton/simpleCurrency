//
//  EmptyListView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 19/06/21.
//

import SwiftUI

struct EmptyListView: View {
    @Binding var isTapped: Bool
    
    var body: some View {
        VStack(spacing: 8.0) {
            Image(systemName: "plus.circle").font(.system(size: 60, weight: .medium))
            Text("Click to add")
                .font(.system(size: 20, weight: .medium, design: .default))
        }
        .foregroundColor(Color.gray.opacity(0.6))
        .onTapGesture {
            isTapped.toggle()
            dismissKeyboard()
        }
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView(isTapped: .constant(false))
    }
}
