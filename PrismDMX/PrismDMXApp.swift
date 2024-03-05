//
//  PrismDMXApp.swift
//  PrismDMX
//
//  Created by simpelMIC on 29.02.24.
//

import SwiftUI

@main
struct PrismDMXApp: App {
    @State var universes: [Universe] = Array(repeating: Universe(channels: Array(repeating: DMXChannel(value: 0), count: 512), enabled: false), count: 50)
    
    var body: some Scene {
        DocumentGroup(newDocument: PrismDMXDocument()) { file in
            ContentView(document: file.$document, universes: $universes)
        }
    }
}
