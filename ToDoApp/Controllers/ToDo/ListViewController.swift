//
//  ListViewController.swift
//  ToDoApp
//
//  Created by Louiz on 04/12/2015.
//  Copyright © 2015 IdeaRobin. All rights reserved.
//


import UIKit
import MagicalRecord

class ListViewController: UITableViewController {
    
    var ToDoItems:[Task]! = []


    @IBOutlet weak var NavigationItem: UINavigationItem!

    override func viewDidAppear(animated: Bool) {
        
        if (Task.MR_countOfEntities() > 0) {
            ToDoItems = Task.MR_findAll() as! [Task]
        }

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 145.0/255.0, green: 78.0/255.0,blue: 95.0/255.0, alpha: 1.0)
        
        self.tableView.backgroundColor = UIColor(red: 79.0/255.0, green: 43.0/255.0,blue: 53.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: LABEL.DEFAULT_FONT, size: CGFloat(LABEL.DEFAULT_FONT_NAV_SIZE ))!, NSForegroundColorAttributeName: UIColor(red: 226.0/255.0, green: 185.0/255.0,blue: 199.0/255.0, alpha: 1.0)]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CustomCell {
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        let width = CGFloat(1.0)
        var numerator = 0
        var denominator = 0
        for (idx, dict) in ToDoItems.enumerate() {

            if(indexPath.row == idx)
            {
                let subTasks = SubTask.MR_findByAttribute("task", withValue: ToDoItems[idx]) as! [SubTask]
                Cell.CellLabel.text = dict.task
                denominator = subTasks.count
                for (_, subTask) in subTasks.enumerate() {
                    if (subTask.is_checked) {
                        numerator++
                    }
                }
                
            }
        }
        
        Cell.CellTaskDate.text = String(numerator) + " | " + String(denominator)

        
        if indexPath.row % 2 == 0 {
            Cell.contentView.backgroundColor = UIColor(red: 145.0/255.0, green: 78.0/255.0,blue: 95.0/255.0, alpha: 1.0)

        } else {
            Cell.contentView.backgroundColor = UIColor(red: 114.0/255.0, green: 65.0/255.0,blue: 84.0/255.0, alpha: 1.0)
        }

        Cell.layer.borderWidth = 0.2
        Cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        Cell.layer.frame = CGRect(x: 0, y: Cell.layer.frame.size.height - width, width:  Cell.layer.frame.size.width, height: Cell.layer.frame.size.height)
        Cell.layer.masksToBounds = true
        Cell.CellTaskDate.SetFontSize(25)
        Cell.CellLabel.SetFontSize(17)
        
        
        
        
        return Cell
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {

            ToDoItems.removeAtIndex(indexPath.row).MR_deleteEntity()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()

            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ShowDetail") {
            let SelectedIndexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!
            let DetailViewController: EditItemListViewController = segue.destinationViewController as! EditItemListViewController
            self.navigationController?.navigationBar.tintColor  = UIColor.whiteColor()
            UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: LABEL.DEFAULT_FONT, size: CGFloat(LABEL.DEFAULT_FONT_NAV_SIZE))!, NSForegroundColorAttributeName: UIColor(red: 226.0/255.0, green: 185.0/255.0,blue: 199.0/255.0, alpha: 1.0)], forState: UIControlState.Normal)
            DetailViewController.ToDoData = ToDoItems[SelectedIndexPath.row] as Task

            DetailViewController.Index = SelectedIndexPath.row
        }
    }
    
    
}

