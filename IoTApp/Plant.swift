import Foundation

struct Plant: Identifiable {
    let id = UUID()
    let name: String
    let description: String = "Description"
    let image: String
    let lightLevel: Int
    let temperature: Double
    let humidity: Double
    let soilMoisture: Double
    let requirements: Requirement
}

struct Requirement {
    let lightPerDay: Int
    let expectedHumidity: Double
    let moistureLevel: Double
    let temperatureRange: Array<Double>
}

let samplePlants = [
    Plant(name: "Succulent", image: "scott-webb-succulent-unsplash", lightLevel: 30, temperature: 25.0, humidity: 24.0, soilMoisture: 10.0, requirements: Requirement(lightPerDay: 4, expectedHumidity: 30.0, moistureLevel: 30.0, temperatureRange: [20.0, 30.0])),
    Plant(name: "Monsterra", image: "placeholder", lightLevel: 30, temperature: 25.0, humidity: 20.0, soilMoisture: 10.0, requirements: Requirement(lightPerDay: 12, expectedHumidity: 30.0, moistureLevel: 20.0, temperatureRange: [20.0, 30.0])),
    Plant(name: "Bonsai", image: "placeholder", lightLevel: 30, temperature: 25.0, humidity: 20.0, soilMoisture: 10.0, requirements: Requirement(lightPerDay: 6, expectedHumidity: 30.0, moistureLevel: 20.0, temperatureRange: [20.0, 30.0])),
]
