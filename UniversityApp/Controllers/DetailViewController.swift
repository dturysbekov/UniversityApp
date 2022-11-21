//
//  DetailViewController.swift
//  UniversityApp
//
//  Created by darkhan on 17.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel
    
    init(country: String, domain: String, name: String) {
        viewModel = DetailViewModel(country: country,domain: domain, name: name )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.getName()
        initialize()
    }
    
    func initialize() {
        
        let domainLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = "Domain: \(viewModel.getDomain())"
            return label
        }()
        
        let countryLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = "Country: \(viewModel.getCountry())"
            return label
        }()
        
        view.addSubview(domainLabel)
        domainLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(180)
            make.leading.trailing.equalToSuperview().offset(50)
        }
        
        view.addSubview(countryLabel)
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(domainLabel.snp.top).offset(40)
            make.leading.trailing.equalToSuperview().offset(50)
        }
    }
}
