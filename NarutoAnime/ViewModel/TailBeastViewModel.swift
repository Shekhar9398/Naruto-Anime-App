import Foundation

class TailBeastViewModel {
    let tailBeastEndpoint = "tailed-beasts"
    var tailBeasts: [TailedBeast] = []
    
    func fetchTailBeasts(completion: @escaping (Result<Void, Error>) -> Void) {
        NetworkManager.shared.fetchApiData(with: tailBeastEndpoint, responseType: TailBeastModel.self, limit: 30) { [self] result in
            
            switch result {
            case .success(let response):
                self.tailBeasts = response.tailedBeasts
                print("TailBeasts Data --> \(tailBeasts)")
                completion(.success(()))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
