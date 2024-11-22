import Foundation

struct Plant: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let lightLevel: Int
    let humidity: Double
    let soilMoisture: Double
    let minSoilMoisture: Double
}

let samplePlants = [
    Plant(name: "Testing", image: "placeholder", lightLevel: 30, humidity: 20.0, soilMoisture: 10.0, minSoilMoisture: 10.0)
]
