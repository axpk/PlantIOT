import SwiftUI
import BackgroundTasks

@main
struct IoTAppApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        NotificationManager.shared.requestAuthorization()
        registerBackgroundTask()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                scheduleBackgroundTask()
            }
        }
    }
    
    func registerBackgroundTask() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "IoTApp.BackgroundTask", using: nil) { task in
            handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
    
    func scheduleBackgroundTask() {
        let request = BGAppRefreshTaskRequest(identifier: "IoTApp.BackgroundTask")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 5)
        
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Background task scheduled")
        } catch {
            print("Could not schedule background task: \(error)")
        }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleBackgroundTask()
        print("Running background task")
        task.setTaskCompleted(success: true)
    }
}
