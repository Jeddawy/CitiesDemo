//
//  CitiesResponse.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import Foundation
//MARK: - Cities


// MARK: - City
struct City: Codable {
    var country: String?
    var name: String?
    var id: String?
    var coord: Coord?

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
}

// MARK: - Coord
struct Coord: Codable {
    var lat: String?
    var lon: String?
}
