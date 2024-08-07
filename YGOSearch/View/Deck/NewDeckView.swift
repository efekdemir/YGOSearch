//
//  Untitled.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/7/24.
//

import SwiftUI

struct NewDeckView: View {
    @Binding var isPresented: Bool
    var addDeckAction: (String, String) -> Void

    @State private var deckName: String = ""
    @State private var deckDescription: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Deck Name", text: $deckName)
                TextField("Description", text: $deckDescription)
                Button("Add Deck") {
                    addDeckAction(deckName, deckDescription)
                    isPresented = false
                }
            }
            .navigationBarTitle("New Deck", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
}
