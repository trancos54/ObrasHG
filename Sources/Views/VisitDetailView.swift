import SwiftUI

struct VisitDetailView: View {
    @Binding var visit: Visit
    @EnvironmentObject var store: ProjectStore
    var onUpdate: () -> Void
    
    @State private var showingAddAnnotation = false
    
    var body: some View {
        List {
            Section {
                if let filename = visit.generalImageFilename, let ui = loadImage(named: filename) {
                    Image(uiImage: ui).resizable().scaledToFit().cornerRadius(8)
                } else {
                    Rectangle().fill(Color.gray.opacity(0.2)).frame(height: 160).cornerRadius(8).overlay(Text("Sin imagen"))
                }
                Text(visit.description).padding(.vertical, 4)
            } header: {
                Text(visit.date, style: .date)
            }
            
            Section(header: Text("Anotaciones")) {
                ForEach($visit.annotations) { $annotation in
                    HStack {
                        if let f = annotation.imageFilename, let ui = loadImage(named: f) {
                            Image(uiImage: ui).resizable().frame(width: 72, height: 72).cornerRadius(6)
                        } else {
                            Rectangle().fill(Color.secondary.opacity(0.2)).frame(width: 72, height: 72).cornerRadius(6)
                        }
                        Text(annotation.text).lineLimit(2)
                    }
                }
                .onDelete(perform: deleteAnnotation)
            }
        }
        .navigationTitle("Visita")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { showingAddAnnotation = true } label: { Image(systemName: "square.and.pencil") }
            }
        }
        .sheet(isPresented: $showingAddAnnotation) {
            AnnotationEditorView { new in
                visit.annotations.append(new)
                onUpdate()
                showingAddAnnotation = false
            }
        }
        .onDisappear { onUpdate() }
    }
    
    func deleteAnnotation(at offsets: IndexSet) {
        visit.annotations.remove(atOffsets: offsets)
        onUpdate()
    }
}