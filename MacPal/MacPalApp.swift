import SwiftUI

@main
struct MacPalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 500, height: 600)
    }
}
