//import Foundation
//
//class CharacterViewModel {
//    let characterEndpoint = "characters"
//    var characters: [Character] = []
//    
//    func fetchCharacters(completion: @escaping (Result<Void, Error>) -> Void) {
//        NetworkManager.shared.fetchApiData(with: characterEndpoint, responseType: CharacterResponse.self, limit: 30) { result in
//            
//            switch result {
//            case .success(let response):
//                self.characters = response.characters!
//                print("Characters fetched successfully: \(self.characters.count) characters")
//                completion(.success(()))
//                
//            case .failure(let error):
//                print("Failed to fetch characters: \(error)")
//                completion(.failure(error))
//            }
//        }
//        
//    }
//}
