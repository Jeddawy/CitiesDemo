//
//  SavedCitiesManager.swift
//  CitiesDemo
//
//  Created by Geddawy on 20/08/2022.
//

import Foundation
import CoreData

class SaveCityModel{
    var name: String = ""
    var country: String = ""
    var lat: String = ""
    var lng: String = ""
    init(city: City){
        self.name = city.name ?? ""
        self.country = city.country ?? ""
        self.lat = city.coord?.lat ?? ""
        self.lng = city.coord?.lon ?? ""
        
    }
    
    init(city: SavedCities){
        self.name = city.name ?? ""
        self.country = city.country ?? ""
        self.lat = city.lat ?? ""
        self.lng = city.lon ?? ""
    }
    init(){}
}

class SavedCitiesManager{
    
    private var cities =  [SaveCityModel]()
    var offSet = 0
    var fetchLimit = 50
    private var savePlaceRepo: CoreDataRepository<SavedCities>?
    
    init(savePlaceRepo: CoreDataRepository<SavedCities>? = nil) {
        self.savePlaceRepo = savePlaceRepo ?? CoreDataRepository<SavedCities>()
    }
    
    func getSaveCities() -> [SaveCityModel] {
        cities.removeAll()
        let cities = savePlaceRepo?.getAll()
        for item in cities ?? [] {
            var location = SaveCityModel()
            location.lat = item.lat ?? ""
            location.lng = item.lon ?? ""
            location.name = item.name ?? ""
            location.country = item.country ?? ""
            self.cities.append(location)
        }
        return self.cities
    }
    
    func getSavedBatchedCities() -> [SaveCityModel] {
//        cities.removeAll()
        let cities = savePlaceRepo?.getBatched(fetchOffSet: offSet, fetchLimit: fetchLimit)
        for item in cities ?? [] {
            var location = SaveCityModel()
            location.lat = item.lat ?? ""
            location.lng = item.lon ?? ""
            location.name = item.name ?? ""
            location.country = item.country ?? ""
            self.cities.append(location)
        }
        offSet += fetchLimit
        print("offset--->",offSet, "fetchLimit----->", fetchLimit)
        return self.cities
    }
    
    func getCitiesCount() -> Int{
        if let count = savePlaceRepo?.getCount(){
            print("saved entities count", count)
            return count
        }
        return 0
    }

    func addNewCity(_ location: City?) {
        if let context = savePlaceRepo?.context {
            let savePlaceModel = SavedCities.init(context: context)
            savePlaceModel.lat = location?.coord?.lat
            savePlaceModel.lon = location?.coord?.lon
            savePlaceModel.name = location?.name
            savePlaceModel.country = location?.country
            savePlaceRepo?.register(value: savePlaceModel)
        }
    }
    
}
