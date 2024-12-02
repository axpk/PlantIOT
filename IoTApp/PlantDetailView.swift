import SwiftUI

struct PlantDetailView: View {
    @ObservedObject var dataService = DataService()
    let plantIndex: Int
    
    var body: some View {
        var plant = dataService.plants[plantIndex]
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Plant Overview Section
                HStack (alignment: .top){
                    VStack(alignment: .leading, spacing: 8) {
                        Text(plant.name)
                            .font(.largeTitle)
                            .bold()
                        Text("Last diagnosis: \(plant.lastUpdated)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(plant.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                // Status section
                Text("Current Levels")
                    .font(.headline)
                VStack {
                    HStack {
                        let waterBox = statusBoxView(color: .blue, currentValue: plant.soilMoisture, expectedValue: plant.requirements.moistureLevel)
                        let lightBox = statusBoxView(color: .yellow, currentValue: Double(plant.lightLevel), expectedValue: Double(plant.requirements.lightPerDay))
                        
                        currentCardView(icon: "sun.max.fill", color: .yellow,
                                        title: "Light", currentValue: String(plant.currentLightHours()) + " hrs", boxStatus: lightBox, requiresBox: true)

                        currentCardView(icon: "drop.fill", color: .blue,
                                        title: "Moisture", currentValue: String(plant.soilMoisture), boxStatus: waterBox, requiresBox: true)
                    }
                    HStack {
                        let humidityRange = rangeBarView(icon: "humidity.fill", color: .gray, currentValue: plant.humidity, range: (min: plant.requirements.expectedHumidity - 10, max: plant.requirements.expectedHumidity + 10))
                        let temperatureRange = rangeBarView(icon: "thermometer.medium", color: .green, currentValue: plant.temperature, range: (min: plant.requirements.temperatureRange[0], max: plant.requirements.temperatureRange[1]), isTemperature: true)
                        
                        currentCardView(icon: "humidity.fill", color: .gray, title: "Humidity", currentValue: String(plant.humidity), range: humidityRange, requiresRange: true)
                        currentCardView(icon: "thermometer.medium", color: .green, title: "Temp", currentValue: String(plant.temperature) + " F", range: temperatureRange, requiresRange: true)
                    }
                }

                // Info section
                Text("Information")
                    .font(.headline)
                Text(plant.description)
                    .foregroundColor(.gray)
                
                // Requirements section
                Text("Requirements")
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        RequirementCardView(
                            icon: "sun.max.fill",
                            color: .yellow,
                            title: "Light",
                            requirementValue: String(plant.requirements.lightPerDay) + " hrs a day"
                        )
                        RequirementCardView(
                            icon: "humidity.fill",
                            color: .gray,
                            title: "Humidity",
                            requirementValue: String(plant.requirements.expectedHumidity) + "%"
                        )
                        RequirementCardView(
                            icon: "drop.fill",
                            color: .blue,
                            title: "Moisture",
                            requirementValue: String(plant.requirements.moistureLevel) + "%"
                        )
                        RequirementCardView(
                            icon: "thermometer.medium",
                            color: .green,
                            title: "Temperature Range (F)",
                            requirementValue: String(plant.requirements.temperatureRange[0]) + "-" + String(plant.requirements.temperatureRange[1])
                        )
                    }
                }
            }
            .padding()
        }
        .navigationTitle(plant.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if plantIndex == 0 {
                dataService.fetchData()
            }
        }
    }
    
    
}

struct statusBoxView: View {
    
    var color: Color
    var currentValue: Double
    var expectedValue: Double
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(.systemGray4))
                .frame(width: 20, height: 60)
            RoundedRectangle(cornerRadius: 6)
                .fill(color)
                .frame(width: 20, height: calculateProgressOffset())
                .offset(y: 10)
        }
        .padding(6)
    }
    
    private func calculateProgressOffset() -> CGFloat {
        let progress = currentValue / expectedValue
        let clampedProgress = max(0, min(1, progress))
        return clampedProgress * 60
    }
}

struct rangeBarView: View {
    var icon: String
    var color: Color
    var currentValue: Double
    var range: (min: Double, max: Double)
    var isTemperature: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    Capsule()
                        .fill(dynamicColor.opacity(0.6))
                        .frame(height: 8)
                    Circle()
                        .stroke(Color.white.opacity(0.8), lineWidth: 2)
                        .fill(dynamicColor)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                        .frame(width: 16)
                        .offset(x: calculateProgressOffset(barWidth: geometry.size.width))
                }
                .frame(height: 8)
            }
            HStack {
                Text("\(String(format: "%.1f", range.min))")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(String(format: "%.1f", range.max))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
    
    private var dynamicColor: Color {
        if isTemperature {
            if currentValue < range.min + 2 {
                return .blue
            } else if currentValue > range.max - 2 {
                return .red
            } else {
                return color
            }
        } else {
            return color
        }
    }
    
    private func calculateProgressOffset(barWidth: CGFloat) -> CGFloat {
        let progress = (currentValue - range.min) / (range.max - range.min)
        let clampedProgress = max(0, min(1, progress))
        return clampedProgress * barWidth - 6 // 6 is half 12
    }
}

struct currentCardView: View {
    var icon: String
    var color: Color
    var title: String
    var currentValue: String
    var range: rangeBarView?
    var requiresRange: Bool = false
    var boxStatus: statusBoxView?
    var requiresBox: Bool = false
    var isLight: Bool = false
    
    var body: some View {
        VStack (spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(color)
            HStack {
                Text(title)
                    .font(.headline)
                Text("\(currentValue)")
                    .font(.subheadline)
                
            }
            if requiresRange {
                range
            }
            if requiresBox {
                boxStatus
            }
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct RequirementCardView: View {
    var icon: String
    var color: Color
    var title: String
    var requirementValue: String
    
    var body: some View {
        VStack (spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(title)
                .font(.headline)
            Text("\(requirementValue)")
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    PlantDetailView(plantIndex: 0)
}
