//
//  PrismDMXDocument.swift
//  PrismDMX
//
//  Created by simpelMIC on 29.02.24.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static let prismDMXDocument = UTType(exportedAs: "de.prismdmx.micstudios.pmx")
}

struct PrismDMXDocument: FileDocument, Codable {
    var workspace: Workspace
    
    init(workspace: Workspace = Workspace(settings: Settings(fixtureGroups: [], sACNSettings: sACNSettings(useBuiltInEngine: true, host: "127.0.0.1", port: "5568", priority: "100")))) {
        self.workspace = workspace
    }

    static var readableContentTypes: [UTType] { [.prismDMXDocument] }

    init(configuration: ReadConfiguration) throws {
        let data = configuration.file.regularFileContents!
        self = try JSONDecoder().decode(Self.self, from: data)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(self)
        return .init(regularFileWithContents: data)
    }
}

