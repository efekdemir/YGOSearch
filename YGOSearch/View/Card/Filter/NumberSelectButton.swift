//
//  RangeSlider.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/27/24.
//

import SwiftUI

struct NumberSelectButton: View {
    let number: Int
    @Binding var selectedNumbers: Set<Int>
    
    var body: some View {
        Button(action: {
            if selectedNumbers.contains(number) {
                selectedNumbers.remove(number)
            } else {
                selectedNumbers.insert(number)
            }
        }) {
            Text("\(number)")
                .frame(width: 23, height: 23) 
                .foregroundColor(selectedNumbers.contains(number) ? .white : .black)
                .background(selectedNumbers.contains(number) ? Color.blue : Color.gray)
                .clipShape(.circle)
        }
    }
}
