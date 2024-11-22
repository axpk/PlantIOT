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
            .navigationTitle("My Plants")
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
            // Plant Image here
            VStack(alignment: .leading) {
                Text(plant.name)
                    .font(.headline)
                Text("Plant Type")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack {
                HStack {
                    Image(systemName: "sun.max.fill")
                    Text("Light level %")
                }
                HStack {
                    Text("Humidity Level")
                }
                HStack {
                    Image(systemName: "drop.fill")
                    Text("Moisture level")
                }
            }
            .foregroundColor(.blue)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}
