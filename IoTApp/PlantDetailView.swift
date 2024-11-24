import SwiftUI

struct PlantDetailView: View {
    var plant: Plant
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Plant Overview Section
                HStack (alignment: .top){
                    VStack(alignment: .leading, spacing: 8) {
                        Text(plant.name)
                            .font(.largeTitle)
                            .bold()
                        Text("Last diagnosis: 10m ago")
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
                        currentCardView(icon: "sun.max.fill", color: .yellow,
                                        title: "Light", currentValue: String(plant.lightLevel) + " lumens")
                        
                        currentCardView(icon: "drop.fill", color: .blue,
                                        title: "Soil Moisture", currentValue: String(plant.soilMoisture))
                    }
                    HStack {
                        let humidityRange = rangeBarView(icon: "humidity.fill", color: .gray, currentValue: plant.humidity, range: (min: plant.requirements.expectedHumidity - 10, max: plant.requirements.expectedHumidity + 10))
                        let temperatureRange = rangeBarView(icon: "thermometer.medium", color: .green, currentValue: plant.temperature, range: (min: plant.requirements.temperatureRange[0], max: plant.requirements.temperatureRange[1]), isTemperature: true)
                        
                        currentCardView(icon: "humidity.fill", color: .gray, title: "Humidity", currentValue: String(plant.humidity), range: humidityRange, requiresRange: true)
                        currentCardView(icon: "thermometer.medium", color: .green, title: "Temperature", currentValue: String(plant.temperature), range: temperatureRange, requiresRange: true)
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
                            title: "Temperature Range (C)",
                            requirementValue: String(plant.requirements.temperatureRange[0]) + "-" + String(plant.requirements.temperatureRange[1])
                        )
                    }
                }
            }
            .padding()
        }
        .navigationTitle(plant.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}

struct statusCircleView: View {
    var body: some View {
        VStack {
            
        }
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
                Capsule()
                    .fill(Color(dynamicColor).opacity(0.6))
                    .frame(height: 8)
                Circle()
                    .fill(dynamicColor)
                    .frame(width: 12)
                    .offset(x: calculateProgressOffset())
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
            if currentValue < range.min {
                return .blue
            } else if currentValue > range.max {
                return .red
            } else {
                return color
            }
        } else {
            return color
        }
    }
    
    private func calculateProgressOffset() -> CGFloat {
        let progress = (currentValue - range.min) / (range.max - range.min)
        let clampedProgress = max(0, min(1, progress))
        return clampedProgress * 200 - 6 // 6 is half 12
    }
}

struct currentCardView: View {
    var icon: String
    var color: Color
    var title: String
    var currentValue: String
    var range: rangeBarView?
    var requiresRange: Bool = false
    
    var body: some View {
        VStack (spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(title)
                .font(.headline)
            Text("\(currentValue)")
                .font(.subheadline)
            if requiresRange {
                range
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
    PlantDetailView(plant: samplePlants[0])
}
