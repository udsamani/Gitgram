//
//  Follower.swift
//  Gitgram
//
//  Created by Udit Samani on 3/14/19.
//  Copyright © 2019 Udit Samani. All rights reserved.
//

import Foundation

struct Follower: CustomStringConvertible {
    
    var name: String?
    var image: String?
    
    init(name: String, imageURL: String) {
        self.name = name
        self.image = imageURL
    }
    
    var description: String {
        if let name = self.name {
            return "<\(type(of: self)): name = \(name)>"
        } else {
            return "<\(type(of: self))>"
        }
    }

    
}
