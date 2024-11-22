import SwiftUI

struct ContentView: View {
    @StateObject private var dataService = DataService()
    
    let name = "Name"
    var plants = samplePlants
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Text("Hello \(name)!")
                    .font(.title)
                    .bold()
                
                Text("Plants")
                    .font(.headline)
                    .padding(.top)
                
                ScrollView {
                    ForEach(plants) { plant in
                        NavigationLink (destination: PlantDetailView(plant: plant)) {
                            PlantRowView(plant: plant)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                Button(action: {
                    // TODO: Handle button
                }) {
                    Text("+ Add a Plant")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .padding()
                        .cornerRadius(10)
                }
                .padding(.top, 16)
                // dataService.fetchData()
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
                .fill(Color.green)
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
                    Image(systemName: "sun.max.fill")
                        .foregroundColor(.yellow)
                    Text("\(plant.lightLevel)%")
                        .font(.subheadline)
                }
                HStack(spacing: 4) {
                    Image(systemName: "humidity.fill")
                        .foregroundColor(.gray)
                    Text("75")
                        .font(.subheadline)
                }
                HStack(spacing: 4) {
                    Image(systemName: "drop.fill")
                        .foregroundColor(.blue)
                    Text("50%")
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
