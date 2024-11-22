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
                HStack(spacing: 20) {
                    statusIconView(icon: "sun.max.fill", color: .yellow, value: String(plant.lightLevel) + "%", progress: Double(plant.lightLevel) / 100.0)
                    statusIconView(icon: "humidity.fill", color: .gray, value: String(format: "%.0f%%", plant.humidity), progress: plant.humidity / plant.requirements.expectedHumidity)
                    statusIconView(icon: "drop.fill", color: .blue, value: String(format: "%.0f%%", plant.soilMoisture), progress: plant.soilMoisture / plant.requirements.moistureLevel)
                }
                .padding(.vertical, 10)
                

                // Info section
                Text("Information")
                    .font(.headline)
                Text(plant.description)
                    .foregroundColor(.gray)
                
                // Requirements section
                Text("Requirements")
                    .font(.headline)
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
                }
            }
            .padding()
        }
        .navigationTitle(plant.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct statusIconView: View {
    
    var icon: String
    var color: Color
    var value: String
    var progress: Double
    
    var body: some View {
        ZStack {
            // background circle
            Circle()
                .stroke(Color(.systemGray4), lineWidth: 6)
                .frame(width: 80, height: 80)
            // progress circle
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(color, lineWidth: 6)
                .rotationEffect(.degrees(-90))
                .frame(width: 80, height: 80)
            
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                Text(value)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
        }
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
