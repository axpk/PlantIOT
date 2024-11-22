import SwiftUI

struct PlantDetailView: View {
    var plant: Plant
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Plant Overview Section
                HStack {
                    VStack(alignment: .leading) {
                        Text(plant.name)
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                    // Image
                }
                
                HStack {
                    VStack {
                        Image(systemName: "sun.max.fill")
                        Text("\(plant.lightLevel)%")
                            .font(.headline)
                    }
                    VStack {
                        Image(systemName: "drop.fill")
                        Text(String(format: "%.0f%%", plant.soilMoisture))
                            .font(.headline)
                    }
                    Spacer()
                    Text("Last diagnosis")
                }
                
                // Info section
                Text("Information")
                    .font(.headline)
                Text("lorem ipsum")
                    .foregroundColor(.gray)
                
                // Requirements section
                HStack {
                    // foreach requirement
                    Text("Requirement1")
                }
            }
            .padding()
        }
        .navigationTitle(plant.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
