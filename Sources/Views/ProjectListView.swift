import SwiftUI

struct ProjectListView: View {
    @EnvironmentObject var store: ProjectStore
    @State private var showingAdd = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.projects) { project in
                    NavigationLink {
                        ProjectDetailView(project: binding(for: project))
                    } label: {
                        HStack(spacing: 12) {
                            Image("Logo")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(radius: 2)
                            VStack(alignment: .leading) {
                                Text(project.title).font(.headline)
                                if let loc = project.location {
                                    Text(loc).font(.subheadline).foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Obras")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAdd = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                ProjectEditorView { new in
                    store.addProject(new)
                    showingAdd = false
                }
            }
        }
    }
    
    private func binding(for project: Project) -> Binding<Project> {
        guard let idx = store.projects.firstIndex(where: { $0.id == project.id }) else {
            return .constant(project)
        }
        return $store.projects[idx]
    }
    
    private func delete(at offsets: IndexSet) {
        for i in offsets {
            store.removeProject(store.projects[i].id)
        }
    }
}