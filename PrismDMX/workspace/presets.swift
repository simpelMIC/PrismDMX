//
//  presets.swift
//  PrismDMX
//
//  Created by Christian Savage on 02.03.24.
//

import Foundation
import SwiftUI

struct fixturePresets {
    @State var fixturePresets: [Fixture] = [
        //Tour LED 42cm
        Fixture(name: "Expolite TourLED 42cm AR1.d", type: "RGB", startingChannel: 1, universe: 1, channels: [FixtureChannel(num: 1, name: "MASTER", type: "MASTER"), FixtureChannel(num: 2, name: "Red", type: "Red"), FixtureChannel(num: 3, name: "Green", type: "Green"), FixtureChannel(num: 4, name: "Blue", type: "Blue")]),
        //Auro Spot 100/200
        Fixture(name: "Auro Spot 100/200 5ch", type: "Moving Head", startingChannel: 1, universe: 1, channels: [FixtureChannel(num: 1, name: "Dimmer", type: "MASTER"), FixtureChannel(num: 2, name: "Strobe", type: "Strobe"), FixtureChannel(num: 3, name: "Auto", type: "Auto"), FixtureChannel(num: 4, name: "Auto Speed", type: "Auto Speed"), FixtureChannel(num: 5, name: "Reset", type: "Reset")])
        //Lixada DMX-512 RGBW LED Stage PAR
        
        //Lixada 7x10 Moving Head
        
        //Lixada Mini Gobo Moving Head
        
        //Lixada Mini Moving Head
    ]
}
