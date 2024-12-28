//
//  User.swift
//  SwiftDataProject
//
//  Created by Jasper Tan on 12/26/24.
//


import SwiftData
import Foundation

@Model
class User {
    
    var name: String
    var city: String
    var joinDate: Date
    
    //@Relationship macro makes it so when you delete a User from SwiftData, the corresponding Job gets deleted as well
    @Relationship(deleteRule: .cascade) var jobs: [Job] = []
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
