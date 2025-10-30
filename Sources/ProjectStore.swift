import Foundation
import SwiftUI

@MainActor
final class ProjectStore: ObservableObject {
    @Published private(set) var projects: [Project] = []
    
    private let storageURL: URL = FileManager.documentsDirectory.appendingPathComponent("projects.json")
    
    func load() {
        DispatchQueue.global(qos: .userInitiated).async {
            let decoder = JSONDecoder()
            if let data = try? Data(contentsOf: self.storageURL),
               let decoded = try? decoder.decode([Project].self, from: data) {
                DispatchQueue.main.async {
                    self.projects = decoded
                }
            } else {
                DispatchQueue.main.async {
                    self.projects = [Project.demo()]
                    self.save()
                }
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .utility).async {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            if let data = try? encoder.encode(self.projects) {
                try? data.write(to: self.storageURL, options: .atomic)
            }
        }
    }
    
    // CRUD
    func addProject(_ p: Project) {
        projects.append(p)
        save()
    }
    func updateProject(_ p: Project) {
        guard let idx = projects.firstIndex(where: { $0.id == p.id }) else { return }
        projects[idx] = p
        save()
    }
    func removeProject(_ id: UUID) {
        projects.removeAll { $0.id == id }
        save()
    }
}