//
//  SearchViewController.swift
//  UniversityApp
//
//  Created by darkhan on 06.11.2022.
//

import UIKit
import Alamofire
import SnapKit

protocol AddUniversityDelegate {
    func addUniversity(university: University)
}

final class SearchViewController: UIViewController {
    
    var delegate: AddUniversityDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    private let cellIdentifier = "cellId"
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        loadUniversities()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        edgesForExtendedLayout = []
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func loadUniversities() {
        viewModel.loadData(name: "") { apiData in
            self.viewModel.universites = apiData
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getUniversities().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SearchTableViewCell
        let name = viewModel.getUniversities()[indexPath.row].name
        let image = UIImage(systemName: "plus")
        
        cell.configureCell(name: name, image: image!)
        let state = viewModel.getState(at: indexPath.row)
        cell.setAddedState(state)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUnviersity = viewModel.getUniversities()[indexPath.row]
        
        if !viewModel.isContainSelectedUniversity(name: selectedUnviersity.name) {
            viewModel.insertUniversity(name: selectedUnviersity.name)
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            delegate?.addUniversity(university: selectedUnviersity)
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text else { return }
        APIHandler.sharedInstanse.fetchingAPIData(name: name) {apiData in
            self.viewModel.universites = apiData
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked( _ searchBar: UISearchBar) {
        searchBar.text = nil
        
        APIHandler.sharedInstanse.fetchingAPIData(name: "") { apiData in
            self.viewModel.universites = apiData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
