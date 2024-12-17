import Foundation

enum ApiError: Error {
    case invalidUrl
    case noData
    case failedToParse(Error)
    case networkError(String)
    case httpError(Int)   
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    var baseUrl = "https://dattebayo-api.onrender.com/"
    
    func fetchApiData<T: Decodable>(with endpoint: String, responseType: T.Type, limit: Int = 30, completion: @escaping (Result<T, ApiError>) -> Void) {
        
        // Append the limit query parameter to the endpoint
        var urlString = baseUrl + endpoint
        
        if urlString.contains("?") {
            urlString += "&limit=\(limit)"
        } else {
            urlString += "?limit=\(limit)"
        }
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for network error
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            // Safely unwrap data
            guard let data = data else {
                print("Error: No data received.")
                completion(.failure(.noData))
                return
            }

            // Parse JSON
            do {
                let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(jsonResponse))
                print("\n--- Successfully Fetched the JSON data ---")
            } catch let error {
                print("\n--- Failed To Fetch JSON data : \(error.localizedDescription) ---")
                completion(.failure(.failedToParse(error)))
            }
        }
        
        task.resume()
    }

}
