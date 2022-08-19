//
//  CitiesServices.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import Foundation

extension APIManager{
    //PayTabs
    static func cityList(page: Int,completion: @escaping (Result<[City]?, Error>, _ code: Int?) -> ()){
        request(APIRouter.cities(page)){
            response, code in
            completion(response, code)
        }
    }
}
