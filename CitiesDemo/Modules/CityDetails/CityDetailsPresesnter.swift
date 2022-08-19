//
//  CityDetailsPresesnter.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import Foundation
import CoreLocation
import UIKit.UIImage
import GoogleMaps
class CityDetailsPresenter{
    private weak var view: CityDetailsViewControllerProtocol?
    private var city: City!
    
    init(view: CityDetailsViewControllerProtocol, city: City){
        self.city = city
        self.view = view
    }
    
}

extension CityDetailsPresenter: CityDetailsPresenterProtocol{
    func load() {
        setupStation()
    }
    
}

extension CityDetailsPresenter{
    private func setupStation(){
        let position = CLLocationCoordinate2D(latitude: self.city.coord?.lat?.toDouble() ?? 0, longitude: self.city.coord?.lon?.toDouble() ?? 0)
        self.view?.setup(coordinate: position, title: "\(city.name ?? ""), \(city.country ?? "")")
    }
}
