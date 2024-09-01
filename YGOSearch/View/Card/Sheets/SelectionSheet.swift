//
//  SelectionSheet.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/29/24.
//

import SwiftUI

struct SelectionSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedItems: Set<String>
    
    let items: [String]
    var title: String

    var body: some View {
        NavigationView {
            let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(items, id: \.self) { item in
                        Button(action: {
                            if selectedItems.contains(item) {
                                selectedItems.remove(item)
                            } else {
                                selectedItems.insert(item)
                            }
                        }) {
                            Text(item)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(selectedItems.contains(item) ? .white : .black)
                                .background(selectedItems.contains(item) ? Color.blue : Color.gray)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationBarItems(leading: Text(title).bold())
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
