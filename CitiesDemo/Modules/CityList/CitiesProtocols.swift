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
    func goToCityDetails(city: City)
}

protocol CitiesPresenterProtocol{
    func loadCities()
    func getNextPaginationPage()
    func didTapCity(at index: Int)
    func getCity(at index: Int) -> City
    func citiesCount() -> Int
}
