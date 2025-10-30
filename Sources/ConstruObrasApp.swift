import SwiftUI

@main
struct ConstruObrasApp: App {
    @StateObject private var store = ProjectStore()
    
    var body: some Scene {
        WindowGroup {
            ProjectListView()
                .environmentObject(store)
                .onAppear {
                    store.load()
                }
        }
    }
}