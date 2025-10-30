import SwiftUI

struct ProjectEditorView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var location: String = ""
    @State private var client: String = ""
    var onSave: (Project) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Título", text: $title)
                    TextField("Localización", text: $location)
                    TextField("Cliente", text: $client)
                }
            }
            .navigationTitle("Nueva Obra")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        let p = Project(title: title, location: location.isEmpty ? nil : location, client: client.isEmpty ? nil : client)
                        onSave(p)
                        dismiss()
                    }.disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
    }
}