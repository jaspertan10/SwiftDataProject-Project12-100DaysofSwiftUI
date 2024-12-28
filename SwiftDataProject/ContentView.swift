//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Jasper Tan on 12/26/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    //Query gets SwiftData and filters/ sorts the data received.
    @Query(filter: #Predicate<User> { user in
        //LocalizedStandarcContains ignores letter case
        user.name.localizedStandardContains("R")
    }, sort: \User.name) var users: [User]
    
    var body: some View {
        NavigationStack{
            List(users) { user in
                Text(user.name)
            }
            .navigationTitle("Users")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    
                    try? modelContext.delete(model: User.self)
                    
                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Remove Samples", systemImage: "minus") {
                        
                        
                        do {
                            try modelContext.delete(model: User.self)
                            
                            //In general SwiftData autosaves. It is during save that the items are properly removed.
                            try modelContext.save()
                        } catch {
                            print("Error removing samples: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
