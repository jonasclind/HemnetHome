// HomeViewModel.swift

import Foundation

class HomeViewModel: ObservableObject {
    @Published var area: Area?
    @Published var properties = [Property]()
    @Published var highlightedProperties = [Property]()

    @Published var homeDetails: PropertyDetails?

    init() {
        fetchHomes()
    }

    // Function to fetch homes data
    func fetchHomes() {
        guard let url = URL(string: "https://pastebin.com/raw/nH5NinBi") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    print("Error: \(error)")
                    // handle error and update UI
                } 
                else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(Response.self, from: data)
                        for item in response.items {
                            switch item {
                            case .area(let area):
                                self.area = area
                            case .property(let property):
                                self.properties.append(property)
                            case .highlightedProperty(let property):
                                self.highlightedProperties.append(property)
                            }
                        }
                    } catch {
                        print("Unable to decode homes data: \(error)")
                        // handle error and update UI
                    }
                }
            }
        }

        task.resume()
    }

    // Function to fetch home details
    func fetchHomeDetails(for id: String) {
        // We only have one home details, so the id will not be used in this case
        
        guard let url = URL(string: "https://pastebin.com/raw/uj6vtukE") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error)")
                    // handle error and update UI
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let details = try decoder.decode(PropertyDetails.self, from: data)
                        self.homeDetails = details
                    } catch {
                        print("Unable to decode home details data: \(error)")
                        // handle error and update UI
                    }
                }
            }
        }

        task.resume()
    }
}
