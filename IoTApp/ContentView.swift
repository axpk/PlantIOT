import SwiftUI

struct ContentView: View {
    @StateObject private var dataService = DataService()
    
    let name = "John"
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                HStack {
                    Text("Hello, \(name)!")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        // TODO: Handle button
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 40)
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        }
                    }
                }
                                
                Text("Your Plants")
                    .font(.headline)
                    .padding(.top)
                
                ScrollView {
                    ForEach(dataService.plants.indices, id: \.self) { index in
                        NavigationLink (destination: PlantDetailView(dataService: dataService, plantIndex: index)) {
                            PlantRowView(plant: dataService.plants[index])
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding()
            .navigationBarHidden(true)
            .onAppear() {
                dataService.startObserving()
            }
            .onDisappear() {
                dataService.stopObserving()
            }
        }
    }
}

struct PlantRowView: View {
    var plant: Plant
    
    var body: some View {
        HStack {
            // TODO - Plant Image here
            // Placeholder image
            Circle()
                .fill(Color.gray)
                .frame(width: 50, height: 50)
                .overlay(Text(plant.name.prefix(1))
                    .font(.headline)
                    .foregroundColor(.white)
                )
                .padding(.trailing, 8)
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(plant.name)
                    .font(.headline)
                Text("Plant Type")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 8) {
                HStack(spacing: 4) {
                    Image(systemName: "thermometer.medium")
                        .foregroundColor(.orange)
                    Text(String(format: "%.0f%", plant.temperature) + " F")
                        .font(.subheadline)
                }
                HStack(spacing: 4) {
                    Image(systemName: "humidity.fill")
                        .foregroundColor(.gray)
                    Text(String(format: "%.0f%%", plant.humidity))
                        .font(.subheadline)
                }
                HStack(spacing: 4) {
                    Image(systemName: "drop.fill")
                        .foregroundColor(.blue)
                    Text(String(format: "%.0f%%", plant.soilMoisture))
                        .font(.subheadline)
                }
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}
