import Foundation
import SwiftUI
import UniformTypeIdentifiers

// MARK: - Models

struct Project: Identifiable, Codable, Equatable {
    var id: UUID = .init()
    var title: String
    var location: String?
    var client: String?
    var createdAt: Date = .now
    var visits: [Visit] = []
    
    static func demo() -> Project {
        Project(title: "Obra Demo", location: "Ciudad", client: "Cliente S.A.")
    }
}

struct Visit: Identifiable, Codable, Equatable {
    var id: UUID = .init()
    var date: Date = .now
    var generalImageFilename: String? // saved in Documents directory
    var description: String = ""
    var annotations: [Annotation] = []
}

struct Annotation: Identifiable, Codable, Equatable {
    var id: UUID = .init()
    var imageFilename: String? // saved in Documents directory
    var text: String = ""
}

// MARK: - File helpers

extension FileManager {
    static var documentsDirectory: URL {
        default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

func saveImageData(_ data: Data, named: String) throws -> String {
    let filename = named
    let url = FileManager.documentsDirectory.appendingPathComponent(filename)
    try data.write(to: url, options: .atomic)
    return filename
}

func loadImage(named filename: String) -> UIImage? {
    let url = FileManager.documentsDirectory.appendingPathComponent(filename)
    guard let data = try? Data(contentsOf: url) else { return nil }
    return UIImage(data: data)
}