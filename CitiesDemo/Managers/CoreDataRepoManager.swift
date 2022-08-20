//
//  CoreDataRepoManager.swift
//  CitiesDemo
//
//  Created by Geddawy on 20/08/2022.
//


import Foundation
import CoreData
import UIKit

class CoreDataRepository<T: NSManagedObject> {

    var context: NSManagedObjectContext?
    
    init(context: NSManagedObjectContext? = nil) {
        let appD = UIApplication.shared.delegate as! AppDelegate
        let myContext = appD.persistentContainer.viewContext
        self.context = context ?? myContext
        
    }
    
    private func getEntityName<T>(type: T.Type)-> String {
        let FullName = String(describing: type)
        let splitName = FullName.split(separator: ".")
        return  splitName.count > 1 ?  splitName[0].base : FullName
    }
    
    @discardableResult
    func getAll() -> [T]? {
        let EntityName = getEntityName(type: T.self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        let objects = try? context!.fetch(request) as? [T]
        return objects
    }
    
    @discardableResult
    func query(with: String) -> [T]? {
        let EntityName = getEntityName(type: T.self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        request.predicate = NSPredicate(format: with)
        let objects = try? context!.fetch(request) as? [T]
        return objects
    }
    
    @discardableResult
    func register(value: T) -> T?{
        
        var result = false
        do {
            try context!.save()
            result = true
        } catch _ as NSError {
         result = false
        }
        return result == true ? value : nil
        
    }
    
    @discardableResult
    func deleteAll() -> [T]? {
           let EntityName = getEntityName(type: T.self)
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
           let objects = try? context!.fetch(request) as? [T]
            for item in objects ?? [] {
                context!.delete(item)
            }
            try? context?.save()
           return objects
    }
    
    @discardableResult
    func delete(with: String) -> [T]? {
           let EntityName = getEntityName(type: T.self)
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
           request.predicate = NSPredicate(format: with)
           let objects = try? context!.fetch(request) as? [T]
            for item in objects ?? [] {
                context!.delete(item)
            }
            try? context?.save()
           return objects
    }
    
}
