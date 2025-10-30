import SwiftUI

struct AnnotationEditorView: View {
    @Environment(\.dismiss) var dismiss
    @State private var text: String = ""
    @State private var pickedImage: UIImage?
    @State private var showingPicker = false
    var onSave: (Annotation) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                TextEditor(text: $text).frame(minHeight: 120)
                if let pickedImage {
                    Image(uiImage: pickedImage).resizable().scaledToFit().frame(height: 180).cornerRadius(8)
                    Button("Quitar foto") { pickedImage = nil }
                } else {
                    Button("Añadir foto") { showingPicker = true }
                }
            }
            .navigationTitle("Nueva Anotación")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        var a = Annotation(text: text)
                        if let img = pickedImage, let data = img.jpegData(compressionQuality: 0.8) {
                            let name = "annotation-\(UUID().uuidString).jpg"
                            try? saveImageData(data, named: name)
                            a.imageFilename = name
                        }
                        onSave(a)
                        dismiss()
                    }.disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
            .sheet(isPresented: $showingPicker) {
                ImagePicker(sourceType: .photoLibrary) { img in
                    pickedImage = img
                }
            }
        }
    }
}