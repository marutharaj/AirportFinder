//
//  AirportViewController.swift
//  AirportFinder
//
//  Created by mac on 10/4/19.
//

import UIKit

class AirportViewController: UIViewController {
    
    @IBOutlet var airportTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: AirportViewModelProtocol! {
        didSet {
            
            viewModel.didReceiveAirport = { [unowned self] viewModel in
                self.activityIndicator.removeFromSuperview()
                self.airportTableView.reloadData()
            }
            
            viewModel.didFailReceiveAirport = { [unowned self] error in
                self.activityIndicator.removeFromSuperview()
                self.showAlert(message: "Unable to get airports")
            }
        }
    }
    
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
}

extension AirportViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAccessibilityLabel()
        showActivityIndicator()
        viewModel = AirportViewModel()
        viewModel.getAirports()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "airportDetailSegueIdentifier" {
            searchBar.resignFirstResponder()
            let viewController = segue.destination as? AirportDetailViewController
            let airportIndex = airportTableView.indexPathForSelectedRow!.row
            viewController?.airport = viewModel.nearestAirports[airportIndex]
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let shouldPerformSegue = viewModel.shouldShowCities
        if viewModel.shouldShowCities {
            let indexPath = airportTableView.indexPathForSelectedRow!
            viewModel.findNearestAirport(by: indexPath.row)
        }
        
        return !shouldPerformSegue
    }
}

extension AirportViewController {
    
    // MARK: - Private Methods
    
    fileprivate func setupAccessibilityLabel() {
        airportTableView.accessibilityLabel = "AirportTableView"
        searchBar.accessibilityIdentifier = "CitySearchBar"
        searchBar.accessibilityLabel = "CitySearchBar"
        searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
    }
    
    fileprivate func showActivityIndicator() {
        // Add it to the view where you want it to appear
        view.addSubview(activityIndicator)
        
        // Set up its size (the super view bounds usually)
        activityIndicator.frame = view.bounds
        // Start the loading animation
        activityIndicator.startAnimating()
    }
    
    fileprivate func showAlert(message: String) {
        
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.shouldShowCities = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterAirports(by: searchText)
    }
}
