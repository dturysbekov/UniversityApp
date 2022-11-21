//
//  APIHandler.swift
//  UniversityApp
//
//  Created by darkhan on 06.11.2022.
//

import Foundation
import Alamofire

class APIHandler {
    static let sharedInstanse = APIHandler()
    func fetchingAPIData(name: String, handler: @escaping (_ apiData: [University]) -> (Void)) {
        AF.request("http://universities.hipolabs.com/search?&country=\(name)").response { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode([University].self, from: data!)
                    handler(jsondata)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
