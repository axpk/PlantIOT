import SwiftUI
import BackgroundTasks

@main
struct IoTAppApp: App {
    
    init() {
        NotificationManager.shared.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
