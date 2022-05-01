//
//  NetworkCore.swift
//  AppNews
//
//  Created by Роман on 24.04.2022.
//

import Foundation

typealias CoreResult<T: Responsable> = Swift.Result<T, Error>

enum NetworkError: Error {
    case invalidURL
    case responseDecodingError
    case decodingError
}

class NetworkCore {
    static let instance = NetworkCore()
    
    private init() {}
    
    private let url = "https://newsapi.org/v2/everything?q=keyword&apiKey=\(key)"
    private let jsonDecoder = JSONDecoder()
}

extension NetworkCore {
    func fetchData(from metadata: String?,
                   completion: @escaping(Result<[Article],NetworkError>) -> Void) {
        guard let url = URL(string: NetworkCore.instance.url) else {
            completion(.failure(.invalidURL))
            return
        }
        urlSessionMethod(with: url, completion: completion)
    }
    
    private func urlSessionMethod(with url:URL,
                                  completion: @escaping
                                  (Result<[Article],NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response , error in
            if let data = data,
                error == nil,
               (response as? HTTPURLResponse)?.statusCode == 200 {
                do {
                    let result = try self.jsonDecoder.decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                    print(result)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}




































//        URLSession.shared.dataTask(with: url) { data, response , error in
//            if let data = data,
//                error == nil,
//               (response as? HTTPURLResponse)?.statusCode == 200{
//                do {
//                    let result =  try self.jsonDecoder.decode(APIResponse.self, from: data)
//                    completion(.success(result.articles))
//                } catch {
//                    completion(.failure(.decodingError))
//                }
//            }
//        }.resume()
