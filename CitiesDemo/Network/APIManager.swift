//
//  APIManager.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import Foundation
import Alamofire

class APIManager{
    
}

extension APIManager {
    
    // MARK:- The request function to get results in a closure
    internal static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>, _ code: Int?) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value), response.response?.statusCode)
            case .failure(let error):
                completion(.failure(error), response.response?.statusCode)
            }
        }
        .responseJSON { response in
            print(response)
            print(response.response?.statusCode)
        }
    }
}
