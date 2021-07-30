//
//  NetworkManager.swift
//  NetXMov
//
//

import Foundation
import Alamofire

class NetworkManager {
  
  let baseURL = "https://api.themoviedb.org/3"
  
  static let sharedInstance: NetworkManager = {
    return NetworkManager()
  }()
  
}

extension NetworkManager {
  
  //MARK: - Parsing JSON
  private func parsingJSON(data: Data) -> Result<Data, NError> {
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
      
      if let jsonData = json["data"] as? [String: Any] {
        ///create json from data
        let jsonData = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
        return .success(jsonData)
      }
      
      if let jsonData = json["data"] as? [[String: Any]] {
        ///create json array from data
        let jsonData = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
        return .success(jsonData)
      }
      
      if let jsonData = json["data"] as? String {
        ///create json dictionary if data just a string
        let jsonDict = ["message": jsonData]
        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)
        return .success(jsonData)
      }
      
    }catch {
      return .failure(.serializationError)
    }
    
    return .failure(.undefinedError)
  }
}

extension NetworkManager {
  
  func request(with url: String,
               withMethod method: HTTPMethod? = .get,
               withHeaders headers: HTTPHeaders = [:],
               withParameter parameters: Parameters = [:],
               withEncoding encoding: ParameterEncoding? = URLEncoding.default,
               completion: @escaping(Result<Data, NError>) -> Void) {
    
    AF.request(self.baseURL.appending(url),
               method: method ?? .get,
               parameters: parameters,
               encoding: encoding ?? URLEncoding.default,
               headers: headers)
      .responseString(queue: DispatchQueue.main, encoding: String.Encoding.utf8, completionHandler: { (response) in
        
        guard let statusCode = response.response?.statusCode else {
          completion(.failure(.undefinedError))
          return
        }
        
        if 200 ... 299 ~= statusCode  {
          //success
          guard let data = response.data else {
            completion(.failure(.undefinedError))
            return
          }
          completion(.success(data))
          
        } else if statusCode == 401 {
          completion(.failure(.unauthorized))
          
        } else if statusCode == 404 {
          completion(.failure(.undefinedError))
          
        } else if statusCode == 500 {
          ///internal server error
          completion(.failure(.internalServerError))
          
        } else {
          /// throw unknown error
          completion(.failure(.undefinedError))
          
        }
      })
  }
}

extension NetworkManager {
  
  func loadJSONFromFile(with filename: String, completion: @escaping(Result<Data, NError>) -> Void) {
    if let path = Bundle.main.path(forResource: filename, ofType: "json") {
      do {
        let rawData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        completion(parsingJSON(data: rawData))
      }catch {
        completion(.failure(.parseError))
      }
    }else {
      completion(.failure(.sourceNotFound))
    }
  }
}

