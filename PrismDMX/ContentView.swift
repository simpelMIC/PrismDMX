//
//  ContentView.swift
//  PrismDMX
//
//  Created by simpelMIC on 29.02.24.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: PrismDMXDocument

    var body: some View {
        MainWorkspaceView(workspace: $document.workspace)
    }
}

#Preview {
    ContentView(document: .constant(PrismDMXDocument()))
}
