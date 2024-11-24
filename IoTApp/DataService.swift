import Foundation
import Combine

struct DataModel: Codable {
    let humidity: Double
    let temperature: Double
    let lightLevel: Int
    let moistureLevel: Double
}

class DataService: ObservableObject {
    @Published var currentHumidity: Double = 0
    @Published var currentTemp: Double = 0
    @Published var currentLight: Int = 0
    @Published var currentMoistureLevel: Double = 0

    private var timer: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
//    let urlString = "http://localhost:3000/data" // Test server data
    let urlString = "http://10.251.158.108" // Change to arduino data

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
                self?.currentHumidity = decodedData.humidity
                self?.currentTemp = decodedData.temperature
                self?.currentLight = decodedData.lightLevel
                self?.currentMoistureLevel = decodedData.moistureLevel
                self?.checkThreshold()
            })
            .store(in: &cancellables)
    }
    
    func checkThreshold() {
        let threshold: Double = 100 // TODO - change to actual values
        if currentHumidity > threshold {
            NotificationManager.shared.scheduleNotification(title: "Threshold Alert", body: "Value Exceeded \(threshold): \(currentHumidity)")
        }
    }
    
}

