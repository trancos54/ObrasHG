import SwiftUI

struct ProjectDetailView: View {
    @Binding var project: Project
    @State private var showingAddVisit = false
    @EnvironmentObject var store: ProjectStore
    
    var body: some View {
        List {
            Section(header: Text("Información")) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(project.title).font(.title2).bold()
                    if let client = project.client { Text("Cliente: \(client)").font(.subheadline) }
                    if let loc = project.location { Text("Localización: \(loc)").font(.subheadline) }
                }
                .padding(.vertical, 6)
            }
            
            Section(header: Text("Visitas")) {
                ForEach($project.visits) { $visit in
                    NavigationLink {
                        VisitDetailView(visit: $visit, onUpdate: save)
                    } label: {
                        HStack {
                            if let filename = visit.generalImageFilename, let ui = loadImage(named: filename) {
                                Image(uiImage: ui).resizable().frame(width: 64, height: 64).cornerRadius(6)
                            } else {
                                Rectangle().fill(Color.gray.opacity(0.3)).frame(width: 64, height: 64).cornerRadius(6)
                            }
                            VStack(alignment: .leading) {
                                Text(visit.date, style: .date)
                                Text(visit.description).lineLimit(1).foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteVisit)
            }
        }
        .navigationTitle("Obra")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddVisit = true
                } label: { Image(systemName: "calendar.badge.plus") }
            }
        }
        .sheet(isPresented: $showingAddVisit) {
            VisitEditorView { new in
                project.visits.append(new)
                save()
                showingAddVisit = false
            }
        }
        .onDisappear {
            store.updateProject(project)
        }
    }
    
    func deleteVisit(at offsets: IndexSet) {
        project.visits.remove(atOffsets: offsets)
        save()
    }
    
    func save() {
        store.updateProject(project)
    }
}