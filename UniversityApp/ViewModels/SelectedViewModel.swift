//
//  SelectedViewModel.swift
//  UniversityApp
//
//  Created by darkhan on 17.11.2022.
//

import UIKit
import CoreData

class SelectedViewModel {
    
    private var list = [UniversityList]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func setCoreData(){
        
        list.removeAll()
        let fetchRequest: NSFetchRequest<UniversityList> = UniversityList.fetchRequest()
        if let objects = try? appDelegate.persistentContainer.viewContext.fetch(fetchRequest) {
            list = objects
            print(list.count)
        }
    }

    func deleteUniversity(at row: Int) {
        let context = appDelegate.persistentContainer.viewContext
        context.delete(list[row])
        do {
            try context.save()
        } catch {
            context.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func getUniversitiesList() -> [UniversityList]{
        list
    }

    func getUniversityData(at row: Int) -> University {
        let data = University(country: list[row].country!, name: list[row].name!, alphaTwoCode: list[row].alpha_two_code!, domains: [list[row].domains!], webPages: [list[row].web_pages!])
        
        return data
    }
}


