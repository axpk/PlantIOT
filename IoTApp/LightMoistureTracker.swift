import Foundation

class LightTracker: ObservableObject {
    
    private var totalLightHours: Int = 0
    private var lastUpdated: Date = Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date()
    private let lightThreshold: Int = 100
    
    init() {
        print("Last Updated: ", lastUpdated)
        let test = Int(Date().timeIntervalSince(lastUpdated) / 3600)
        print(test)
    }
    
    func updateLight(currentLight: Int) {
        let now = Date()
        let elapsedTime = Int(now.timeIntervalSince(lastUpdated) / 3600) // elapsed time in hrs
//        let elapsedTime = Int(now.timeIntervalSince(lastUpdated)) // elapsed time in seconds

        if currentLight >= lightThreshold {
            totalLightHours += elapsedTime
            saveLightHours()
        }
        lastUpdated = now
    }
    
    private func saveLightHours() {
        let defaults = UserDefaults.standard
        defaults.set(totalLightHours, forKey: "totalLightHours")
    }
    
    func getTotalLightHours() -> Int {
        return totalLightHours
    }
}

