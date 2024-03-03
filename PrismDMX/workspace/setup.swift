//
//  setup.swift
//  PrismDMX
//
//  Created by Christian Savage on 01.03.24.
//

import Foundation
import SwiftUI
import Combine

struct SetupView: View {
    @Binding var settings: Settings
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: FixtureSettingsView(groups: $settings.fixtureGroups, fixtureTemplates: $fixturePresets)) {
                    Text("Fixture Settings")
                }
                NavigationLink(destination: sACNSettingsView(sACNSettings: $settings.sACNSettings)) {
                    Text("sACN Settings")
                }
            }
        }
    }
    
    @State var fixturePresets: [Fixture] = [
        //Tour LED 42cm
        Fixture(name: "Expolite TourLED 42cm AR1.d", type: "RGB", startingChannel: 1, universe: 1, channels: [FixtureChannel(num: 1, name: "MASTER", type: "MASTER"), FixtureChannel(num: 2, name: "Red", type: "Red"), FixtureChannel(num: 3, name: "Green", type: "Green"), FixtureChannel(num: 4, name: "Blue", type: "Blue")]),
        //Auro Spot 100/200
        Fixture(name: "Auro Spot 100/200 5ch", type: "Moving Head", startingChannel: 1,universe: 1, channels: [FixtureChannel(num: 1, name: "Dimmer", type: "MASTER"), FixtureChannel(num: 2, name: "Strobe", type: "Strobe"), FixtureChannel(num: 3, name: "Auto", type: "Auto"), FixtureChannel(num: 4, name: "Auto Speed", type: "Auto Speed"), FixtureChannel(num: 5, name: "Reset", type: "Reset")])
        //Lixada DMX-512 RGBW LED Stage PAR
        
        //Lixada 7x10 Moving Head
        
        //Lixada Mini Gobo Moving Head
        
        //Lixada Mini Moving Head
    ]
}


struct FixtureSettingsView: View {
    @Binding var groups: [FixtureGroup]
    @State var localGroups: [FixtureGroup] = []
    
    @Binding var fixtureTemplates: [Fixture]
    @State var localFixtureTemplates: [Fixture] = []
    
    var body: some View {
        VStack {
            Text("Fixture Settings")
                .font(.system(.largeTitle, weight: .semibold))
                .padding(.top)
            TabView {
                //
                List(localGroups.indices, id: \.self) { index in
                    NavigationLink(destination: GroupView(group: localGroups[index])) {
                        Text(groups[index].name)
                    }
                }
                .tabItem { Text("Groups") }
                .toolbar(content: {
                    Button {
                        groups.append(FixtureGroup(name: "New Group", fixtures: []))
                    } label: {
                        Text("New Group")
                    }
                })
                //
                List(localGroups.indices, id: \.self) { index in
                    NavigationLink(destination: GroupView(group: localGroups[index])) {
                        Text(groups[index].name)
                    }
                }
                .tabItem { Text("Groups") }
                .toolbar(content: {
                    Button {
                        groups.append(FixtureGroup(name: "New Group", fixtures: []))
                    } label: {
                        Text("New Group")
                    }
                })
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        .onAppear {
            localGroups = groups
            localFixtureTemplates = fixtureTemplates
        }
        .onDisappear {
            groups = localGroups
            fixtureTemplates = localFixtureTemplates
        }
    }
}

struct GroupView: View {
    var group: FixtureGroup
    
    var body: some View {
        Text("Group")
    }
}

struct sACNSettingsView: View {
    @Binding var sACNSettings: sACNSettings
    
    var body: some View {
        ScrollView {
            VStack {
                Text("sACN Settings")
                    .font(.system(.largeTitle, weight: .semibold))
                    .padding(.top)
                Section("Networking") {
                    HStack {
                        Text("Priority")
                        TextField("0-200", text: $sACNSettings.priority)
                    }
                    HStack {
                        Text("Host")
                        TextField("127.0.0.1", text: $sACNSettings.host)
                    }
                }
                Section("sACN") {
                    HStack {
                        Text("Use built in sACN Engine:")
                        Text("\(sACNSettings.useBuiltInEngine ? "true" : "false")")
                    }
                    HStack {
                        Text("Port")
                        TextField("5568", text: $sACNSettings.port)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    SetupView(settings: .constant(PrismDMXDocument().workspace.settings))
}
