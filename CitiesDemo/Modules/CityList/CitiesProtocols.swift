//
//  CitiesProtocols.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import Foundation

protocol CitiesViewControllerProtocol: AnyObject {
    func showLoader()
    func hideLoader()
    func updateTableview()
    func showError(error: String)
    func goToCityDetails(city: SaveCityModel)
}

protocol CitiesPresenterProtocol{
    func loadCities()
    func getNextPaginationPage()
    func didTapCity(at index: Int)
    func getCity(at index: Int) -> SaveCityModel
    func citiesCount() -> Int
    func didTypeSearch(searchText: String)
}
