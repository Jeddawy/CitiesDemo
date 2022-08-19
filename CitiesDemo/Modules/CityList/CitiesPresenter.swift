//
//  CitiesPresenter.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import Foundation

class CitiesPresenter{
    private let lastPage: Int = 4192
    private weak var view: CitiesViewControllerProtocol?
    private var pageNumber: Int = 1
    private var cities: [City]?
    init(view: CitiesViewControllerProtocol){
        self.view = view
    }
}

extension CitiesPresenter: CitiesPresenterProtocol{
    func loadCities() {
        self.pageNumber = 1
        self.cities = nil
        self.getCities()
    }
    
    func getNextPaginationPage() {
        if pageNumber < lastPage {
            pageNumber += 1
            self.getCities()
        }
    }
    
    func didTapCity(at index: Int) {
        if index >= 0 && index < (cities?.count ?? 0), let city = cities?[index]{
            self.view?.goToCityDetails(city: city)
        }
    }
    
    func getCity(at index: Int) -> City {
        if index < cities?.count ?? 0 && index >= 0 {
            return cities?[index] ?? City()
        }
        return City()
    }
    
    func citiesCount() -> Int {
        return cities?.count ?? 0
    }
    
    
    
}
extension CitiesPresenter{
    private func getCities(){
        self.view?.showLoader()
        APIManager.cityList(page: self.pageNumber) { response, code in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showError(error: "Something went wrong")
            case .success(let result):
                guard let cities = result else {return}
                    if self.cities != nil {
                        self.cities? += cities
                    } else {
                        self.cities = cities
                    }
                self.view?.updateTableview()
            }
            self.view?.hideLoader()
        }
    }
}
