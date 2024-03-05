//
//  sACN.swift
//  PrismDMX
//
//  Created by simpelMIC on 05.03.24.
//

import Foundation
import SwiftUI
import Network
import sACN

class sACNController {
    @Binding var universes: [Universe]
    @State var isStreaming: Bool = false
    
    init(universes: Binding<[Universe]>) {
        self._universes = universes
    }
    
    func timer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1/50) {
            if self.isStreaming == true {
                self.timer()
                self.sendDMXData()
            }
        }
    }
    
    func start() {
        isStreaming = true
        timer()
    }
    
    func stop() {
        isStreaming = false
    }
    
    func sendDMXData() {
        
    }
}
