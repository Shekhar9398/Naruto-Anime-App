import Foundation

class CharacterViewModel {
    var characterNames: [String] = []
    var characterImages: [[String]] = []
    
    // Closure for callback when data is fetched
    var onFetchComplete: (() -> Void)?
    
    func fetchCharacters() {
        // API Endpoint
        let urlString = "https://dattebayo-api.onrender.com/characters"
        
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
                   let characters = jsonDictionary["characters"] as? [[String: Any]] {
                    
                    // Clear previous data before appending
                    self.characterNames.removeAll()
                    self.characterImages.removeAll()
                    
                    // Store names and images
                    for dict in characters {
                        if let name = dict["name"] as? String {
                            self.characterNames.append(name)
                        }
                        
                        if let images = dict["images"] as? [String] {
                            self.characterImages.append(images)
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
