//
//  main.swift
//  PrismDMX
//
//  Created by simpelMIC on 29.02.24.
//

import Foundation
import SwiftUI

struct MainWorkspaceView: View {
    @Binding var workspace: Workspace
    @Binding var universes: [Universe]
    
    @State var sideBarVisibility: NavigationSplitViewVisibility = .doubleColumn
    @State var selectedSideBarItem: SideBarItem = .channels
    
    var body: some View {
        NavigationSplitView(columnVisibility: $sideBarVisibility) {
            List(SideBarItem.allCases, selection: $selectedSideBarItem) { item in
                NavigationLink(
                    item.rawValue.localizedCapitalized,
                    value: item
                )
            }
        } detail: {
            switch selectedSideBarItem {
            case .setup:
                SetupView(settings: $workspace.settings, universes: $universes)
            case .channels:
                ChannelsView()
            case .playbacks:
                PlaybackView()
            }
        }
    }
}

enum SideBarItem: String, Identifiable, CaseIterable {
    var id: String { rawValue }
    
    case setup
    case channels
    case playbacks
}

struct ChannelsView: View {
    var body: some View {
        Text("Channels")
    }
}

struct PlaybackView: View {
    var body: some View {
        Text("Playbacks")
    }
}

#Preview {
    ContentView(document: .constant(PrismDMXDocument()), universes: .constant([]))
}
