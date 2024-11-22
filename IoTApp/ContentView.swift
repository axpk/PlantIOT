import SwiftUI

struct ContentView: View {
    @StateObject private var dataService = DataService()
    
    let name = "Name"
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Hello \(name)!")
                .font(.title)
                .bold()
            
            Text("Plants")
                .font(.headline)
                .padding(.top)
            
            ScrollView {
                
            }
            
            Button(action: {}) {
                Text("+ Add a Plant")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .padding()
                    .cornerRadius(10)
            }
            
            
//            Text("Current Value: \(dataService.currentHumidity)")
//                .font(.largeTitle)
//                .padding()
//            Button(action: {
//                dataService.fetchData()
//            }) {
//                Text("Fetch Data")
//                    .font(.title2)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
        }
        .padding()
        .onAppear() {
            dataService.startObserving()
        }
        .onDisappear() {
            dataService.stopObserving()
        }
    }
}

struct PlantRowView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Plant name")
                    .font(.headline)
                Text("Plant Type")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack {
                HStack {
                    Text("Light level %")
                }
                HStack {
                    Text("Humidity Level")
                }
                HStack {
                    Text("Moisture level")
                }
            }
            
        }
        .padding(.vertical, 0)
    }
}

#Preview {
    ContentView()
}
