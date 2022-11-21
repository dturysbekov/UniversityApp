//
//  Displayable.swift
//  UniversityApp
//
//  Created by darkhan on 06.11.2022.
//

protocol Displayable {
    var listItems: [String] { get }
    var listPages: [String] { get }
    var subtitleLabelText: String { get }
    var titleLabelText: String { get }
}
