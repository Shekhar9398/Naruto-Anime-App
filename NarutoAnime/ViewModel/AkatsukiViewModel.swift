
import Foundation

class AkatsukiViewModel {
    var akatsukiNames: [String] = []
    var akatsukiImages: [[String]] = []
    
    // Closure for callback when data is fetched
    var onFetchComplete: (() -> Void)?
    
    func fetchAkatsuki() {
        // API Endpoint
        let urlString = "https://dattebayo-api.onrender.com/akatsuki"
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create a URLSession data task
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return } // Prevent retain cycles
            
            // Handle errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Ensure data exists
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                // Parse JSON into a dictionary
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   
                   let akatsuki = jsonDictionary["akatsuki"] as? [[String: Any]] {
                    
                    // Clear previous data before appending
                    self.akatsukiNames.removeAll()
                    self.akatsukiImages.removeAll()
                    
                    // Store names and images
                    for dict in akatsuki {
                        if let name = dict["name"] as? String {
                            self.akatsukiNames.append(name)
                        }
                        
                        if let images = dict["images"] as? [String] {
                            self.akatsukiImages.append(images)
                        }
                    }
                    
                    // Notify when fetch is complete
                    DispatchQueue.main.async {
                        self.onFetchComplete?()
                    }
                } else {
                    print("Failed to cast JSON")
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
