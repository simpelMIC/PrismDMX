// The Swift Programming Language
// https://docs.swift.org/swift-book

import DefaultBackend
import SwiftCrossUI
import Figlet

@main
struct PrismDMXApp: App {
    var body: some Scene {
        WindowGroup() {
            Text("Hello World!")
            .onAppear() {
                Figlet.say("PrismDMX")
            }
        }
    }
}