//
//  University.swift
//  UniversityApp
//
//  Created by darkhan on 06.11.2022.
//

import Foundation

// MARK: - WelcomeElement
struct University: Codable {
    
    let country: String
    let name: String
    let alphaTwoCode: String
    let domains: [String]
    let webPages: [String]

    enum CodingKeys: String, CodingKey {
        case domains
        case alphaTwoCode = "alpha_two_code"
        case webPages = "web_pages"
        case country
        case name
    }
}


extension University: Displayable {

    var listItems: [String] {
        domains
    }

    var listPages: [String] {
        webPages
    }

    var subtitleLabelText: String {
        "Country \(String(country))"
    }

    var titleLabelText: String {
        name
    }
}

  


