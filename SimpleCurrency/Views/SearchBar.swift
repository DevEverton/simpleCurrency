//
//  SearchBar.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 07/06/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var isEditing = false
    
     
    var body: some View {
        HStack(spacing: 0.0) {
            Image(systemName: "magnifyingglass").font(.system(size: 25, weight: .semibold))
                .foregroundColor(Color.gray.opacity(0.4))

            TextField("search currency", text: $searchText)
                .padding(5)
                .background(Color.gray.opacity(0.4))
                .foregroundColor(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .animation(.spring())
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .onChange(of: searchText, perform: { value in
                    if searchText.count > 20 {
                        searchText = String(searchText.dropLast())
                    }

                })
                .autocapitalization(.none)

            if isEditing {
                Button(action: {
                    self.searchText = ""
                    self.isEditing = false
                    hideKeyboard()
 
                }) {
                    Image(systemName: "x.circle.fill").font(.system(size: 20, weight: .regular))
                        .foregroundColor(Color.red)

                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
                
            }

        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding(10)
            
    }
}