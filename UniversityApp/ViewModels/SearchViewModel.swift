//
//  ViewModel.swift
//  UniversityApp
//
//  Created by darkhan on 11.11.2022.
//

import Foundation
import UIKit
import CoreData

class SearchViewModel {
    
    var universites : [University] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var selectedUniversities: Set<String> = []
    
    func loadData(name: String, handler: @escaping (_ apiData: [University]) -> (Void)) {
        APIHandler.sharedInstanse.fetchingAPIData(name: name) { apiData in
            handler(apiData)
        }
    }
    
    func getUniversities() -> [University]{
        universites
    }

    func getState(at row: Int) -> Bool {
        selectedUniversities.contains(universites[row].name)
    }

    func isContainSelectedUniversity(name: String) -> Bool {
        selectedUniversities.contains(name)
    }
    
    func insertUniversity(name: String) {
        
        let optionalData = universites.first(where: {
            $0.name == name
        })
        if let details = optionalData {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "UniversityList", in: context)!
            let university = NSManagedObject(entity: entity, insertInto: context)
            university.setValue(details.country, forKey: "country")
            university.setValue(details.name, forKey: "name")
            university.setValue(details.domains[0], forKey: "domains")
            university.setValue(details.alphaTwoCode, forKey: "alpha_two_code")
            university.setValue(details.webPages[0], forKey: "web_pages")
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    context.rollback()
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
        selectedUniversities.insert(name)
        print(name)
        appDelegate.saveContext()
    }
}
