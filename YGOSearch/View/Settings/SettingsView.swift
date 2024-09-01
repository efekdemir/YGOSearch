//
//  Settings.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/16/24.
//
import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("fontSize") private var fontSize = 14.0
    @AppStorage("selectedLanguage") private var selectedLanguage = "en"
    
    private let languages = ["English": "en", "French": "fr", "German": "de", "Italian": "it", "Portuguese": "pt"]
    private var languageNames: [String] {
        Array(languages.keys).sorted()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")
                    .adjustableFontSize()) {
                        Toggle(isOn: $isDarkMode) {
                            Text("Dark Mode")
                                .adjustableFontSize()
                        }
                        .onChange(of: isDarkMode) { newValue in
                            updateInterfaceStyle(isDarkMode: newValue)
                        }
                        
                        HStack {
                            Text("Font Size")
                                .adjustableFontSize()
                            Slider(value: $fontSize, in: 10...22, step: 1)
                        }
                    }
                
                Section(header: Text("Card Language").adjustableFontSize()) {
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(languageNames, id: \.self) { name in
                            Text(name)
                                .tag(languages[name]!)
                                .adjustableFontSize()
                        }
                    }
                }
                
                Section(header: Text("Other Settings")
                    .adjustableFontSize()) {
                        Text("Version: 1.0.0")
                            .adjustableFontSize()
                    }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
    
    private func updateInterfaceStyle(isDarkMode: Bool) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.forEach { window in
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}

extension View {
    func adjustableFontSize() -> some View {
        modifier(AdjustableFontSizeModifier())
    }
}

struct AdjustableFontSizeModifier: ViewModifier {
    @AppStorage("fontSize") var fontSize: Double = 14.0
    
    func body(content: Content) -> some View {
        content.font(.system(size: CGFloat(fontSize)))
    }
}
