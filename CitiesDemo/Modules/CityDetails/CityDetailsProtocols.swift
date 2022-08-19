//
//  CityDetailsProtocols.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import Foundation
import GoogleMaps
protocol CityDetailsViewControllerProtocol: AnyObject{
    func setup(coordinate: CLLocationCoordinate2D, title: String)
}


protocol CityDetailsPresenterProtocol: AnyObject{
    func load()
}

