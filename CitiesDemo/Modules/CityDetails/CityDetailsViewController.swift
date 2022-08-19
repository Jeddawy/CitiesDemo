//
//  CityDetailsViewController.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import UIKit
import GoogleMaps

class CityDetailsViewController: UIViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var mapview: GMSMapView!
    //MARK: - Variables
    private var presenter: CityDetailsPresenterProtocol!
    
    // MARK: - Public Methods
    class func create(city: City) -> CityDetailsViewController {
        let VC: CityDetailsViewController = CityDetailsViewController()
        VC.presenter = CityDetailsPresenter(view: VC, city: city)
        return VC
    }


}
//MARK: - Life cycle
extension CityDetailsViewController{
  
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
        // Do any additional setup after loading the view.
    }


}

//MARK: - Presenter -> View
extension CityDetailsViewController: CityDetailsViewControllerProtocol{
    func setup(coordinate coordinates: CLLocationCoordinate2D, title: String) {
        let marker = GMSMarker(position: coordinates)
        mapview.camera = GMSCameraPosition(target: coordinates, zoom: 12)
        marker.icon = UIImage(named: "pin")
        marker.map = mapview
        setViewControllerTitle(to: title)

    }
}
