//
//  CitiesViewController.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import UIKit

class CitiesViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: - Variables
    private var presenter: CitiesPresenterProtocol!

    // MARK: - Public Methods
    class func create() -> CitiesViewController {
        let VC: CitiesViewController = CitiesViewController()
        VC.presenter = CitiesPresenter(view: VC)
        return VC
    }

}

//MARK: - Life Cycles
extension CitiesViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadCities()
        setupTableView()
        setViewControllerTitle(to: "Cities")
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
}

//MARK: - UITableView Delegation
extension CitiesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.presenter.citiesCount())
        return self.presenter.citiesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.ID, for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        cell.configureCell(model: presenter.getCity(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapCity(at: indexPath.row)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == presenter.citiesCount() - 1 {
            presenter.getNextPaginationPage()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
//MARK: - Presenter -> View
extension CitiesViewController: CitiesViewControllerProtocol{
    func showLoader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func updateTableview() {
        self.tableview.reloadData()
    }
    
    func showError(error: String) {
        self.showAlert(error)
    }
    
    func goToCityDetails(city: SaveCityModel) {
        let vc = CityDetailsViewController.create(city: city)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension CitiesViewController{
    func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        let nib = UINib(nibName: CityTableViewCell.ID, bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: CityTableViewCell.ID)
    }
}

//MARK: - UI SearChBar
extension CitiesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String)
    {
        presenter.didTypeText(with: searchText)
       
    }
}
