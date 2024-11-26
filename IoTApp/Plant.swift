import Foundation

struct Plant: Identifiable {
    let id = UUID()
    var name: String
    var description: String = "Description"
    var image: String
    var lightLevel: Int
    var temperature: Double
    var humidity: Double
    var soilMoisture: Double
    var requirements: Requirement
}

struct Requirement {
    var lightPerDay: Int
    var expectedHumidity: Double
    var moistureLevel: Double
    var temperatureRange: Array<Double>
}

let samplePlants = [
    Plant(name: "Arduino", description: "Live Arduino Data", image: "scott-webb-succulent-unsplash", lightLevel: 30, temperature: 25.0, humidity: 24.0, soilMoisture: 10.0, requirements: Requirement(lightPerDay: 4, expectedHumidity: 30.0, moistureLevel: 30.0, temperatureRange: [20.0, 30.0])),
    Plant(name: "Succulent", image: "scott-webb-succulent-unsplash", lightLevel: 30, temperature: 25.0, humidity: 24.0, soilMoisture: 10.0, requirements: Requirement(lightPerDay: 4, expectedHumidity: 30.0, moistureLevel: 30.0, temperatureRange: [20.0, 30.0])),
    Plant(name: "Monstera", image: "amy-lister-monstera-unsplash", lightLevel: 30, temperature: 25.0, humidity: 20.0, soilMoisture: 10.0, requirements: Requirement(lightPerDay: 12, expectedHumidity: 30.0, moistureLevel: 20.0, temperatureRange: [20.0, 30.0])),
    Plant(name: "Bonsai", image: "devin-h-bonsai-unsplash", lightLevel: 30, temperature: 11.0, humidity: 20.0, soilMoisture: 10.0, requirements: Requirement(lightPerDay: 6, expectedHumidity: 30.0, moistureLevel: 20.0, temperatureRange: [10.0, 26.0])),
]
