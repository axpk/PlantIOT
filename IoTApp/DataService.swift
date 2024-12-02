import Foundation
import Combine

struct DataModel: Codable {
    let humidity: Double
    let temperature: Double
    let light: Int
    let soilMoisture: Double
}

class DataService: ObservableObject {
    @Published var plants: [Plant] = samplePlants
    
    @Published var accumulatedLightHours: Double = 0.0
    private var lastResetTime: Date = Date()

    private var timer: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
//    let urlString = "http://localhost:3000/data" // Test server data
//    let urlString = "http://10.251.158.108" // Change to arduino data
    let urlString = "http://192.168.68.77" // alternate ip

    init() {
        print("DataService initted")
    }
    
    deinit {
        stopObserving()
        print("DataService deinitted")
    }
    
    func startObserving() {
        stopObserving()
        timer = Timer.publish(every: 3, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchData()
            }
        fetchData()
    }
    
    func stopObserving() {
        timer?.cancel()
        timer = nil
        cancellables.removeAll()
    }
    
    func fetchData() {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        print("Fetching data...")
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: DataModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }, receiveValue: { [weak self] decodedData in
                self?.plants[0].lightLevel = Int(decodedData.light)
                self?.plants[0].humidity = decodedData.humidity
                self?.plants[0].temperature = decodedData.temperature
                self?.plants[0].soilMoisture = decodedData.soilMoisture
                self?.checkThreshold()
            })
            .store(in: &cancellables)
    }
    
    func checkThreshold() {
        
        // Soil Moisture
        if plants[0].getSoilMoisture() < 5.0 {
            NotificationManager.shared.scheduleNotification(title: "\(plants[0].name) needs water", body: "Soil moisture dropped below 5%")
        }
        
        // Temperature
        if (plants[0].temperature < plants[0].requirements.temperatureRange[0]) {
            NotificationManager.shared.scheduleNotification(title: "\(plants[0].name) is too cold!", body: "Temp dropped below \(plants[0].requirements.temperatureRange[0])")
        }
        if (plants[0].temperature > plants[0].requirements.temperatureRange[1]) {
            NotificationManager.shared.scheduleNotification(title: "\(plants[0].name) is too hot!", body: "Temp went above \(plants[0].requirements.temperatureRange[1])")
        }
        
    }
}
