//
//  AppStateManager.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import Foundation
import UIKit

protocol AppStateManagerProtocol {
    func lunch(appDelegate: AppDelegateProtocol)
}

class AppStateManager {
    
    // MARK:- AppState Enum
    enum AppState {
        case home
        case none
    }
    
    // MARK:- Properties
    var appDelegate: AppDelegateProtocol!
    var mainWindow: UIWindow? {
        return self.appDelegate?.getMainWindow()
    }
    
    var state: AppState = .none {
        willSet(newState) {
            switch newState {
            case .home:
                self.switchToHomeState()
            default:
                break
            }
        }
    }
    
    // MARK:- Singleton
    private static let sharedInstance = AppStateManager()
    
    class func shared() -> AppStateManagerProtocol {
        return AppStateManager.sharedInstance
    }
    
    // MARK:- Methods


    func switchToHomeState() {
        let citiesVC = CitiesViewController.create()
        let nav = UINavigationController(rootViewController: citiesVC)
        self.mainWindow?.rootViewController = nav
    }
    
}

extension AppStateManager: AppStateManagerProtocol {
    func lunch(appDelegate: AppDelegateProtocol) {
        self.appDelegate = appDelegate
        self.state = .home
    }
    
    func start(){
        print("state is",state)
    }
    
}
