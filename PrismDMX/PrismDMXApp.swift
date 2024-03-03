//
//  PrismDMXApp.swift
//  PrismDMX
//
//  Created by Christian Savage on 29.02.24.
//

import SwiftUI

@main
struct PrismDMXApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: PrismDMXDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
