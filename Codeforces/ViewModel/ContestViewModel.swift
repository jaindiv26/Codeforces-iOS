//
//  ContestViewModel.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 14/10/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation

protocol ContestListDelegate {
    func getHomeContestList(currentContestList: [GymModel], pastContestList: [GymModel])
    func getGymContestList(list: [GymModel])
    func getUserContestList(list: [ContestModel])
}

class ContestViewModel {
    
    var delegate: ContestListDelegate
    var preferredHandle: String = ""
    
    init(delegate: ContestListDelegate) {
        self.delegate = delegate
    }
    
    init(delegate: ContestListDelegate, preferredHandle: String) {
        self.delegate = delegate
        self.preferredHandle = preferredHandle
    }
    
    public func getHomeContestList() {
        let baseUrl: String = Constants.homeContestList
        
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
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with:
                            dataResponse, options: [])
                        
                        guard let jsonObject = jsonResponse as? NSDictionary else {
                            return
                        }
                        
                        guard let contestList = jsonObject["result"] as? [[String: Any]] else {
                            return
                        }

                        var currentContestList: [GymModel] = []
                        var pastContestList: [GymModel] = []
                        
                        
                        for i in contestList {
                            
                            let gymModel = GymModel.init(
                                id: i["id"] as? Int ?? 0,
                                name: i["name"] as? String ?? "",
                                type: i["type"] as? String ?? "",
                                phase: i["phase"] as? String ?? "",
                                frozen: i["frozen"] as? Bool ?? false,
                                durationSeconds: i["durationSeconds"] as? Int ?? 0,
                                relativeTimeSeconds: i["relativeTimeSeconds"] as? Int ?? 0,
                                startTimeSeconds: i["startTimeSeconds"] as? Int ?? 0
                            )
                            if (gymModel.phase == "BEFORE") {
                                currentContestList.append(gymModel)
                            } else {
                                pastContestList.append(gymModel)
                            }
                        }
                        self?.delegate.getHomeContestList(currentContestList: currentContestList, pastContestList: pastContestList)
                    } catch let parsingError {
                        print("Error in parsing data", parsingError)
                    }
            }
            dataTask?.resume()
        }
    }
    
    public func getGymContestList() {
        let baseUrl: String = Constants.gymContestList
        
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
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with:
                            dataResponse, options: [])
                        
                        guard let jsonObject = jsonResponse as? NSDictionary else {
                            return
                        }
                        
                        guard let contestList = jsonObject["result"] as? [[String: Any]] else {
                            return
                        }
                        
                        var model: [GymModel] = []
                        
                        for i in contestList {
                            
                            let gymModel = GymModel.init(
                                id: i["id"] as? Int ?? 0,
                                name: i["name"] as? String ?? "",
                                type: i["type"] as? String ?? "",
                                phase: i["phase"] as? String ?? "",
                                frozen: i["frozen"] as? Bool ?? false,
                                durationSeconds: i["durationSeconds"] as? Int ?? 0,
                                relativeTimeSeconds: i["relativeTimeSeconds"] as? Int ?? 0,
                                startTimeSeconds: i["startTimeSeconds"] as? Int ?? 0,
                                preparedBy: i["preparedBy"] as? String ?? "",
                                difficulty: i["difficulty"] as? Int ?? 0,
                                kind: i["kind"] as? String ?? "",
                                country: i["country"] as? String ?? "",
                                city: i["city"] as? String ?? "",
                                season: i["season"] as? String ?? ""
                            )
                            model.append(gymModel)
                        }
                        self?.delegate.getGymContestList(list: model)
                    } catch let parsingError {
                        print("Error in parsing data", parsingError)
                    }
            }
            dataTask?.resume()
        }
    }
    
    public func getUserContestList() {
        let baseUrl : String = Constants.userContestList + preferredHandle
        
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
                        self?.delegate.getUserContestList(list: model)
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
