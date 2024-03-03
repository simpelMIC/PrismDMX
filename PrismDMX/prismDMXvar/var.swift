//
//  var.swift
//  PrismDMX
//
//  Created by Christian Savage on 02.03.24.
//

import Foundation

struct Workspace: Identifiable, Codable {
    var id = UUID()
    var settings: Settings
}

struct Settings: Identifiable, Codable {
    var id = UUID()
    var fixtureGroups: [FixtureGroup]
    var sACNSettings: sACNSettings
}

struct sACNSettings: Identifiable, Codable {
    var id = UUID()
    var useBuiltInEngine: Bool
    var host: String
    var port: String
    var priority: String
}

struct FixtureGroup: Identifiable, Codable {
    var id = UUID()
    var name: String
    var fixtures: [Fixture]
}

struct Fixture: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var startingChannel: Int
    var universe: UInt16
    var channels: [FixtureChannel]
}

struct FixtureChannel: Identifiable, Codable {
    var id = UUID()
    var num: Int
    var name: String
    var type: String
}

struct Universe: Identifiable, Codable {
    var id = UUID()
    var num: Int
    var channels: [DMXChannel]
}

struct DMXChannel: Equatable, Identifiable, Codable {
    var id = UUID()
    var value: Double
}
