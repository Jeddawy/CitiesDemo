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
    private var cityList: [SaveCityModel]?{
        didSet{
            self.view?.updateTableview()
        }
    }
    private var retreivedCities: [SaveCityModel]?
    private var savedCities = SavedCitiesManager()
    private var isFiltering = false
    init(view: CitiesViewControllerProtocol){
        self.view = view
    }
}

extension CitiesPresenter: CitiesPresenterProtocol{
    func loadCities() {
        if savedCities.getCitiesCount() == 0 {
            self.pageNumber = 1
            self.cityList = nil
            self.cities = nil
            self.getCities()
        }else{
            self.retreivedCities = savedCities.getSavedBatchedCities()
            self.cityList = self.retreivedCities
        }
    }
    
    func getNextPaginationPage() {
        //TODO: - refactor this
        if isFiltering{
            return
        }
        let savedcount = savedCities.getCitiesCount()
        pageNumber = (savedcount/50)
        print(savedcount, pageNumber)
        if self.retreivedCities?.count ?? 0 < savedcount{
            self.retreivedCities = savedCities.getSavedBatchedCities()
            self.cityList = self.retreivedCities
        }else if pageNumber < lastPage {
            pageNumber += 1
            self.getCities()
        }
        
    }
    
    func didTapCity(at index: Int) {
        if index >= 0 && index < (cityList?.count ?? 0), let city = cityList?[index]{
            self.view?.goToCityDetails(city: city)
        }
    }
    
    func getCity(at index: Int) -> SaveCityModel {
        if index < cityList?.count ?? 0 && index >= 0 {
            return cityList?[index] ?? SaveCityModel()
        }
        return SaveCityModel()
    }
    
    func citiesCount() -> Int {
        return self.cityList?.count ?? 0
    }
    
    func didTypeSearch(searchText: String) {
        if searchText.isEmpty{
            isFiltering = false
            self.cityList = retreivedCities
            return
        }
        isFiltering = true
        self.cityList = retreivedCities?.filter({ $0.name.hasPrefix(searchText)})
        print(self.cityList?.count, searchText, "retreivedcitites", retreivedCities)
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
                        self.handleCity(cities)
                    } else {
                        self.cities = cities
                        self.handleCity(cities)
                    }
            }
            self.view?.hideLoader()
        }
    }
}

extension CitiesPresenter{
    private func handleCity(_ cities: [City]?){
        if let cities = cities {
            var cityList = [SaveCityModel]()
            for city in cities {
                cityList.append(SaveCityModel(city: city))
                savedCities.addNewCity(city)
            }
            self.cityList = savedCities.getSaveCities()
            self.view?.updateTableview()
        }
    }
}
