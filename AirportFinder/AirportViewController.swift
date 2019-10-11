//
//  AirportViewController.swift
//  AirportFinder
//
//  Created by mac on 10/4/19.
//

import UIKit
import AFHandy

class AirportViewController: UIViewController {
    
    @IBOutlet var airportTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var airportHelper: AirportFinderProtocol! {
        didSet {
            
            airportHelper.didReceiveAirport = { [unowned self] airportHelper in
                self.activityIndicator.removeFromSuperview()
                self.airportTableView.reloadData()
            }
            
            airportHelper.didFailReceiveAirport = { [unowned self] error in
                self.activityIndicator.removeFromSuperview()
                self.showAlert(message: "Unable to get airports")
            }
        }
    }
    
    var viewModel: AirportViewModelProtocol!
    
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
}

extension AirportViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAccessibilityLabel()
        showActivityIndicator()
        airportHelper = AirportFinderHelper()
        viewModel = AirportViewModel(airportHelper: airportHelper)
        airportHelper.getAirports()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "airportDetailSegueIdentifier" {
            searchBar.resignFirstResponder()
            let viewController = segue.destination as? AirportDetailViewController
            let airportIndex = airportTableView.indexPathForSelectedRow!.row
            viewController?.airport = airportHelper.nearestAirports[airportIndex]
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let shouldPerformSegue = airportHelper.shouldShowCities
        if airportHelper.shouldShowCities {
            let indexPath = airportTableView.indexPathForSelectedRow!
            airportHelper.findNearestAirport(by: indexPath.row)
        }
        
        return !shouldPerformSegue
    }
}

fileprivate extension AirportViewController {
    
    // MARK: - Private Methods
    
    func setupAccessibilityLabel() {
        airportTableView.accessibilityLabel = "AirportTableView"
        searchBar.accessibilityIdentifier = "CitySearchBar"
        searchBar.accessibilityLabel = "CitySearchBar"
        searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
    }
    
    func showActivityIndicator() {
        // Add it to the view where you want it to appear
        view.addSubview(activityIndicator)
        
        // Set up its size (the super view bounds usually)
        activityIndicator.frame = view.bounds
        // Start the loading animation
        activityIndicator.startAnimating()
    }
    
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: "AirportFinder",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: { (_) in }))
        present(alert,
                     animated: true,
                     completion: {})
    }
}

extension AirportViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Airport table view delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "airportCellId", for: indexPath)
        
        return viewModel.cellForRowAt(indexPath: indexPath, for: cell)
    }
}

extension AirportViewController: UISearchBarDelegate {
    
    // MARK: - Search bar delegate

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        airportHelper.shouldShowCities = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        airportHelper.filterAirports(by: searchText)
    }
}
