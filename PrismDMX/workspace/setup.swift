//
//  setup.swift
//  PrismDMX
//
//  Created by simpelMIC on 01.03.24.
//

import Foundation
import SwiftUI
import Combine

struct SetupView: View {
    @Binding var settings: Settings
    @Binding var universes: [Universe]
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: FixtureGroupSettingsView(groups: $settings.fixtureGroups, fixtureTemplates: $fixturePresets)) {
                    Text("Fixture Settings")
                }
                NavigationLink(destination: sACNSettingsView(sACNSettings: $settings.sACNSettings)) {
                    Text("sACN Settings")
                }
                NavigationLink(destination: universeManagementView(universes: $universes)) {
                    Text("Universe Management")
                }
            }
        }
    }
    
    @State var fixturePresets: [Fixture] = [
        /*
        //Tour LED 42cm
        Fixture(name: "Expolite TourLED 42cm AR1.d", type: "RGB", startingChannel: 1, universe: 1, channels: [FixtureChannel(num: 1, name: "MASTER", type: "MASTER"), FixtureChannel(num: 2, name: "Red", type: "Red"), FixtureChannel(num: 3, name: "Green", type: "Green"), FixtureChannel(num: 4, name: "Blue", type: "Blue")]),
        //Auro Spot 100/200
        Fixture(name: "Auro Spot 100/200 5ch", type: "Moving Head", startingChannel: 1,universe: 1, channels: [FixtureChannel(num: 1, name: "Dimmer", type: "MASTER"), FixtureChannel(num: 2, name: "Strobe", type: "Strobe"), FixtureChannel(num: 3, name: "Auto", type: "Auto"), FixtureChannel(num: 4, name: "Auto Speed", type: "Auto Speed"), FixtureChannel(num: 5, name: "Reset", type: "Reset")])
        //Lixada DMX-512 RGBW LED Stage PAR
        
        //Lixada 7x10 Moving Head
        
        //Lixada Mini Gobo Moving Head
        
        //Lixada Mini Moving Head
         */
    ]
}

struct FixtureGroupSettingsView: View {
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
                VStack {
                    List(localGroups.indices, id: \.self) { index in
                        NavigationLink(destination: GroupView(group: $localGroups[index])) {
                            Text(localGroups[index].name)
                        }
                        .contextMenu(ContextMenu(menuItems: {
                            VStack {
                                Button {
                                    groups.remove(at: index)
                                    localGroups.remove(at: index)
                                } label: {
                                    Text("Delete")
                                }
                            }
                        }))
                    }
                    Button {
                        groups.append(FixtureGroup(name: "New Group", fixtures: []))
                        localGroups.append(FixtureGroup(name: "New Group", fixtures: []))
                    } label: {
                        Text("New Group")
                    }
                    .padding(.bottom, 5)
                }
                .tabItem { Text("Groups") }
                //
                VStack {
                    List(localFixtureTemplates.indices, id: \.self) { index in
                        NavigationLink(destination: FixtureConfigurationView(fixture: $localFixtureTemplates[index])) {
                            Text(localFixtureTemplates[index].name)
                        }
                        .contextMenu(ContextMenu(menuItems: {
                            Button {
                                localFixtureTemplates.append(localFixtureTemplates[index])
                            } label: {
                                Text("Duplicate")
                            }
                            Button {
                                localFixtureTemplates.remove(at: index)
                            } label: {
                                Text("Delete")
                            }
                        }))
                    }
                    Button {
                        fixtureTemplates.append(Fixture(name: "New Fixture Template", type: "Template", startingChannel: 1, universe: 1, channels: []))
                        localFixtureTemplates.append(Fixture(name: "New Fixture Template", type: "Template", startingChannel: 1, universe: 1, channels: []))
                    } label: {
                        Text("New Template")
                    }
                    .padding(.bottom, 5)
                }
                .tabItem { Text("Fixture Types") }
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

//GV1
struct GroupView: View {
    @Binding var group: FixtureGroup
    
    @State var localGroup: FixtureGroup = FixtureGroup(name: "When you see this report to the Developer. Code: GV1", fixtures: [])
    
    @State var isSheetOpened: Bool = false
    
    var body: some View {
        VStack {
            Text(localGroup.name)
                .font(.system(.largeTitle, weight: .semibold))
            Text("Edit Fixtures within this group")
            HStack {
                Button {
                    isSheetOpened.toggle()
                } label: {
                    Text("Rename \(localGroup.name)")
                }
            }
            List(localGroup.fixtures.indices, id: \.self) { index in
                NavigationLink(destination: FixtureConfigurationView(fixture: $localGroup.fixtures[index])) {
                    Text(localGroup.fixtures[index].name)
                }
                .contextMenu(ContextMenu(menuItems: {
                    Button(action: {
                        localGroup.fixtures.append(localGroup.fixtures[index])
                    }, label: {
                        Text("Duplicate")
                    })
                    Button {
                        localGroup.fixtures.remove(at: index)
                    } label: {
                        Text("Delete")
                    }

                }))
            }
            HStack {
                Button {
                    group.fixtures.append(Fixture(name: "New Fixture", type: "Dimmer", startingChannel: 1, universe: 1, channels: []))
                    localGroup.fixtures.append(Fixture(name: "New Fixture", type: "Dimmer", startingChannel: 1, universe: 1, channels: []))
                } label: {
                    Text("New Fixture")
                }
            }
        }
        .onAppear {
            localGroup = group
            isSheetOpened = false
        }
        .onDisappear {
            group = localGroup
        }
        .padding()
        .sheet(isPresented: $isSheetOpened, content: {
            VStack {
                HStack {
                    TextField(text: $localGroup.name, label: {
                        Text("Rename\(localGroup.name)")
                    })
                }
                HStack {
                    Button {
                        isSheetOpened.toggle()
                        group = localGroup
                    } label: {
                        Text("Close")
                    }
                }
            }
            .padding(20)
        })
    }
}

//FCV1
struct FixtureConfigurationView: View {
    @Binding var fixture: Fixture
    @State var localFixture: Fixture = Fixture(name: "If you see this send a report to the Developer. Code: FCV1", type: "temp", startingChannel: 1, universe: 1, channels: [])
    
    var body: some View {
        VStack {
            Text(localFixture.name)
                .font(.system(.largeTitle, weight: .semibold))
            HStack {
                Text("Name")
                TextField("Name", text: $localFixture.name)
            }
            HStack {
                Text("Type")
                TextField("Type", text: $localFixture.type)
            }
            HStack {
                Text("starting Address: ")
                Button {
                    if localFixture.startingChannel < 512 {
                        localFixture.startingChannel = localFixture.startingChannel + 1
                    }
                } label: {
                    Text("+")
                }
                Text(String(localFixture.startingChannel))
                Button {
                    if localFixture.startingChannel > 1 {
                        localFixture.startingChannel = localFixture.startingChannel - 1
                    }
                } label: {
                    Text("-")
                }
            }
            HStack {
                Text("Universe: ")
                Button {
                    if localFixture.universe < 63999 {
                        localFixture.universe = localFixture.universe + 1
                    }
                } label: {
                    Text("+")
                }
                Text(String(localFixture.universe))
                Button {
                    if localFixture.universe > 1 {
                        localFixture.universe = localFixture.universe - 1
                    }
                } label: {
                    Text("-")
                }
            }
            List(localFixture.channels.indices, id: \.self) { index in
                NavigationLink(destination: ChannelConfigurationView(channel: $localFixture.channels[index])) {
                    Text(localFixture.channels[index].name)
                }
                .contextMenu(ContextMenu(menuItems: {
                    Button {
                        localFixture.channels.append(localFixture.channels[index])
                    } label: {
                        Text("Duplicate")
                    }
                    Button {
                        localFixture.channels.remove(at: index)
                    } label: {
                        Text("Delete")
                    }

                }))
            }
            HStack {
                Button {
                    localFixture.channels.append(FixtureChannel(num: localFixture.channels.count + 1, name: "New Channel", type: "Default"))
                } label: {
                    Text("New Channel")
                }
            }
        }
        .onAppear {
            localFixture = fixture
        }
        .onDisappear {
            fixture = localFixture
        }
        .padding(20)
    }
}

//CCV1
struct ChannelConfigurationView: View {
    @Binding var channel: FixtureChannel
    @State var localChannel: FixtureChannel = FixtureChannel(num: 1, name: "If you see this send a report to the Developer. Code: CCV1", type: "temp")
    
    var body: some View {
        ScrollView {
            VStack {
                Text(localChannel.name)
                    .font(.system(.largeTitle, weight: .semibold))
                HStack {
                    Text("Name")
                    TextField("Name", text: $localChannel.name)
                }
                HStack {
                    Text("Number: ")
                    Button {
                        if localChannel.num < 512 {
                            localChannel.num = localChannel.num + 1
                        }
                    } label: {
                        Text("+")
                    }
                    Text(String(localChannel.num))
                    Button  {
                        if localChannel.num > 1 {
                            localChannel.num = localChannel.num - 1
                        }
                    } label: {
                        Text("-")
                    }
                }
            }
        }
        .onAppear {
            localChannel = channel
        }
        .onDisappear {
            channel = localChannel
        }
        .padding()
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
                    HStack {
                        Text("Port")
                        TextField("5568", text: $sACNSettings.port)
                    }
                }
                Section("sACN") {
                    HStack {
                        Text("Use built in sACN Engine:")
                        Text("\(sACNSettings.useBuiltInEngine ? "true" : "false")")
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct universeManagementView: View {
    @Binding var universes: [Universe]
    
    var body: some View {
        Text("Universe Management")
            .font(.system(.largeTitle, weight: .semibold))
        List(universes.indices, id: \.self) { index in
            CheckView(state: $universes[index].enabled, name: "Universe \(index + 1)")
        }
    }
}

struct CheckView: View {
    @Binding var state: Bool
    @State var name: String
    
    var body: some View {
        HStack {
            Toggle(isOn: $state, label: {
                Text(name)
            })
        }
    }
}

#Preview {
    //SetupView(settings: .constant(PrismDMXDocument().workspace.settings))
    //FixtureSettingsView(groups: .constant(PrismDMXDocument().workspace.settings.fixtureGroups), fixtureTemplates: .constant([]))
    universeManagementView(universes: .constant([Universe(channels: Array(repeating: DMXChannel(value: 0), count: 512), enabled: false)]))
}
