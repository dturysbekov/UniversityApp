//
//  DetailViewModel.swift
//  UniversityApp
//
//  Created by darkhan on 17.11.2022.
//

import Foundation

class DetailViewModel {
    
    private var country: String = ""
    private var domain: String = ""
    private var name: String = ""
 
    init(country: String, domain: String, name: String) {
        self.country = country
        self.domain = domain
        self.name = name
    }
    
    func getCountry() -> String {
        country
    }
    
    func getDomain() -> String {
        domain
    }
    
    func getName() -> String {
        name
    }
    
    
    
    
}
