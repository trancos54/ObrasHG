import SwiftUI
import PhotosUI

struct VisitEditorView: View {
    @Environment(\.dismiss) var dismiss
    @State var date: Date = .now
    @State var description: String = ""
    @State private var generalImage: UIImage?
    @State private var showingPicker = false
    var onSave: (Visit) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Fecha", selection: $date, displayedComponents: .date)
                TextEditor(text: $description).frame(minHeight: 100)
                Section {
                    if let generalImage {
                        Image(uiImage: generalImage).resizable().scaledToFit().frame(height: 180).cornerRadius(8)
                        Button("Quitar foto") { self.generalImage = nil }
                    } else {
                        Button("Elegir foto general") { showingPicker = true }
                    }
                }
            }
            .navigationTitle("Nueva Visita")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        var v = Visit(date: date, description: description)
                        if let img = generalImage, let data = img.jpegData(compressionQuality: 0.8) {
                            let name = "visit-\(UUID().uuidString).jpg"
                            try? saveImageData(data, named: name)
                            v.generalImageFilename = name
                        }
                        onSave(v)
                        dismiss()
                    }.disabled(description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
            .sheet(isPresented: $showingPicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    generalImage = image
                }
            }
        }
    }
}