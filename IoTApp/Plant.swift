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
    Plant(name: "Succulent", image: "placeholder", lightLevel: 30, humidity: 20.0, soilMoisture: 10.0, minSoilMoisture: 10.0),
    Plant(name: "Bonsai", image: "placeholder", lightLevel: 30, humidity: 20.0, soilMoisture: 10.0, minSoilMoisture: 10.0),
    Plant(name: "Monsterra", image: "placeholder", lightLevel: 30, humidity: 20.0, soilMoisture: 10.0, minSoilMoisture: 10.0)
]
