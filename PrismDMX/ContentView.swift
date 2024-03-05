//
//  ContentView.swift
//  PrismDMX
//
//  Created by simpelMIC on 29.02.24.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: PrismDMXDocument
    @Binding var universes: [Universe]

    var body: some View {
        MainWorkspaceView(workspace: $document.workspace, universes: $universes)
    }
}

#Preview {
    ContentView(document: .constant(PrismDMXDocument()), universes: .constant([]))
}
