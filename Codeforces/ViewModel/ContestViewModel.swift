//
//  ContestViewModel.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 14/10/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation

protocol ContestListDelegate {
    func getList(list: [ContestModel])
}

class ContestViewModel {
    
    var delegate: ContestListDelegate
    var preferredHandle: String = ""
    
    init(delegate: ContestListDelegate, preferredHandle: String) {
        self.delegate = delegate
        self.preferredHandle = preferredHandle
    }
    
    public func loadItems () {
        let baseUrl : String = "https://codeforces.com/api/user.rating?handle=" + preferredHandle
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        
        if let urlComponents = URLComponents(string: baseUrl) {
            guard urlComponents.url != nil else {
                return
            }
            
            let request = URLRequest(url: urlComponents.url!)
            
            dataTask =
                defaultSession.dataTask(with: request) { [weak self] data, response, error in
                    
                    guard let dataResponse = data,
                        error == nil else {
                            print(error?.localizedDescription ?? "Response Error")
                            return }
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with:
                            dataResponse, options: [])
                        
                        guard let jsonObject = jsonResponse as? NSDictionary else {
                            return
                        }
                        
                        guard let contestList = jsonObject["result"] as? [[String: Any]] else {
                            return
                        }
                        
                        var model: [ContestModel] = []
                        
                        for i in contestList {
                            let newRating: Int = i["newRating"] as? Int ?? 0
                            let oldRating: Int = i["oldRating"] as? Int ?? 0
                            let rating =  newRating - oldRating
                            let contest = ContestModel.init(
                                contestId: i["contestId"] as? Int ?? 0,
                                contestName: i["contestName"] as? String ?? "",
                                contestRank: i["rank"] as? Int ?? 0,
                                oldRating: i["oldRating"] as? Int ?? 0,
                                change: rating,
                                newRating: i["newRating"] as? Int ?? 0
                            )
                            model.append(contest)
                        }
                        self?.delegate.getList(list: model)
                    } catch let parsingError {
                        print("Error in parsing data", parsingError)
                    }
            }
            dataTask?.resume()
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
