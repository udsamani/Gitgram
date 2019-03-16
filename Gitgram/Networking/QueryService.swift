//
//  QueryService.swift
//  Gitgram
//
//  Created by Udit Samani on 3/15/19.
//  Copyright © 2019 Udit Samani. All rights reserved.
//

import Foundation

class QueryService {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Follower]?,String) -> ()
    
    var followers = [Follower]()
    var errorMessage = ""
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    // Function for GET query
    func getFollowerQueryResults(queryItem: String, completion: @escaping QueryResult) {
        
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: "https://api.github.com/users/\(queryItem)/following") {
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { (data, response, error) in
                defer {self.dataTask = nil}
                
                //Unwrapping Error
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data, let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.parseFollowerData(data)
                    DispatchQueue.main.async {
                        print(self.followers.count)
                        completion(self.followers,self.errorMessage)
                    }
                }
            }
            
        }
        dataTask?.resume()
    }
    
    fileprivate func parseFollowerData(_ data: Data) {
        
        var response: NSArray?
        followers.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response else { return }
        //print(array.count)
        
        for followerEntry in array{
            if let followerEntry = followerEntry as? JSONDictionary,
               let login = followerEntry["login"] as? String,
                let imageURL = followerEntry["avatar_url"] as? String {
                followers.append(Follower(name: login, imageURL: imageURL))
            }
                
            
        }
        
    }
    
    
    
}
