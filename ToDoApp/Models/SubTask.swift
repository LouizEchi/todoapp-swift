//
//  SubTask.swift
//  ToDoApp
//
//  Created by Louiz on 06/01/2016.
//  Copyright © 2016 IdeaRobin. All rights reserved.
//

import Foundation
import CoreData

@objc(SubTask)
class SubTask: NSManagedObject {
    
    // Attributes
    @NSManaged var task_name: String
    @NSManaged var is_checked: Bool
    
    // Relationships
    @NSManaged var task: Task
}
