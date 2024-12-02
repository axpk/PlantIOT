import Foundation

struct LightTracker {
    
    private var totalLightHours: Int = 0
    private var lastUpdated: Date = Date()
    private let lightThreshold: Int = 100
    
    mutating func updateLight(currentLight: Int) {
        let now = Date()
        let elapsedTime = Int(now.timeIntervalSince(lastUpdated) / 3600) // elapsed time in hrs
        
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

