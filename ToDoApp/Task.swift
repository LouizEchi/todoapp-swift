//
//  Task.swift
//  ToDoApp
//
//  Created by Louiz on 06/01/2016.
//  Copyright © 2016 IdeaRobin. All rights reserved.
//

import Foundation
import CoreData

@objc(Task)
class Task: NSManagedObject {
    
    // Attributes
    @NSManaged var task: String
    @NSManaged var additional_notes: String
    
    // Relationships
    @NSManaged var subTask: SubTask
}
