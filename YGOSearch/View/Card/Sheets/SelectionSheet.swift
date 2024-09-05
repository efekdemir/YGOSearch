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
    
    private var maxItemWidth: CGFloat {
        maxWidthOfItems(items: items, font: UIFont.systemFont(ofSize: 17))
    }
    
    var body: some View {
        NavigationView {
            let columns = [GridItem(.adaptive(minimum: maxItemWidth))]
            
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
                                .frame(minWidth: maxItemWidth, idealWidth: maxItemWidth, maxWidth: .infinity)
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

func widthOfString(_ string: String, font: UIFont) -> CGFloat {
    let attributes = [NSAttributedString.Key.font: font]
    return string.size(withAttributes: attributes).width
}

func maxWidthOfItems(items: [String], font: UIFont) -> CGFloat {
    let widths = items.map { widthOfString($0, font: font) }
    guard let max = widths.max() else { return 100 }
    return max + 20
}
