//
//  SelectedViewController.swift
//  UniversityApp
//
//  Created by darkhan on 06.11.2022.
//

import UIKit
import Alamofire

class SelectedViewController: UIViewController {
    
    let viewModel = SelectedViewModel()
    
    var tableView = UITableView()
    
    let identifier = "myCell"
    
    var data = [University]()
    
    func getSelectedUniversities() -> Set<String> {
        var result: Set<String> = []
        data.forEach { university in
            result.insert(university.name)
        }
        return result
    }
    
    lazy var addButton = UIButton()
    let identifierButton = "addButton"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.frame = CGRect(x: 10, y: 200, width: 390, height: 600)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        addButton.frame = CGRect(x: 270, y: 60, width: 80, height: 80)
        addButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        
        self.view.addSubview(tableView)
        self.view.addSubview(addButton)
        
        viewModel.setCoreData()
        
        addObservers()
    }
    
    @objc func buttonClicked() {
        
        let controller = SearchViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextObjectsDidChange, object: nil, queue: nil) { [weak self] _ in
            self?.viewModel.setCoreData()
            self?.tableView.reloadData()
        }
    }
    
}

extension SelectedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = viewModel.getUniversityData(at: indexPath.row)
        let detailVC = DetailViewController(country: data.country,
                                            domain: data.domains[0],
                                            name: data.name
                                            )
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SelectedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getUniversitiesList().count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, complectionHandler) in
            
            self.viewModel.deleteUniversity(at: indexPath.row)
            
            complectionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else { return UITableViewCell()}
        
        cell.textLabel?.text = viewModel.getUniversitiesList()[indexPath.row].name
        
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
}

// MARK: - AddContactDelegate


extension SelectedViewController: AddUniversityDelegate {
    func addUniversity(university data: University) {
        self.data.append(data)
        self.tableView.reloadData()
    }
}

