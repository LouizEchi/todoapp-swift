//
//  EditItemListViewController.swift
//  ToDoApp
//
//  Created by Louiz on 07/12/2015.
//  Copyright © 2015 IdeaRobin. All rights reserved.
//

import UIKit
import MagicalRecord

class EditItemListViewController: CustomView , UITableViewDelegate {
    var ToDoData: Task!
    var Index: Int = 0;
    var subTask: [SubTask]! = []

    @IBOutlet weak var MainNavigationItem: UINavigationItem!
    @IBOutlet weak var NewTitleLabel: CustomLabel!
    @IBOutlet weak var TitleTextField: CustomTextField!
    @IBOutlet weak var NoteLabel: CustomLabel!
    @IBOutlet weak var NoteTextField: CustomTextView!
    @IBOutlet weak var AddSubTask: CustomButton!
    @IBOutlet weak var SubTaskTable: UITableView!
    
    @IBOutlet weak var SubTaskText: CustomTextField!
    @IBAction func CreateSubTask(sender: AnyObject) {
        let Sub: SubTask! = SubTask.MR_createEntity() as SubTask!

        if (SubTaskText.text! != "") {
            print ("LOL")
            Sub.task_name = SubTaskText.text!
            Sub.is_checked = false

            Sub.task = ToDoData!
            subTask.append(Sub)
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            self.SubTaskTable.reloadData()
        } else {
            let alert = UIAlertController(title:LABEL.ERROR.EDIT.SUB_TASK.TITLE, message: LABEL.ERROR.EDIT.SUB_TASK.MESSAGE, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }

    
    @IBAction func EditItem(sender: AnyObject) {
        if(TitleTextField.text != "") {
            ToDoData.task = TitleTextField.text!
            ToDoData.additional_notes = NoteTextField.text!
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.subTask = SubTask.MR_findByAttribute("task", withValue: ToDoData) as! [SubTask]

        NewTitleLabel.text! = LABEL.TODO.ADD_LABEL
        NoteLabel.text! = LABEL.TODO.NOTE_LABEL
        NoteTextField.text! = ""
        NoteTextField.SetBorderWidth(0.2)
        NoteTextField.layer.borderColor = UIColor.grayColor().CGColor
        NoteTextField.layer.cornerRadius = CGRectGetWidth(NoteTextField.frame)/25
        NoteTextField.clipsToBounds = true
        
        self.SubTaskTable.delegate = self

        AddSubTask.setTitle(LABEL.TODO.ADD_SUB_TASK, forState: UIControlState.Normal)
        



        TitleTextField!.text = ToDoData.task
        NoteTextField!.text = ToDoData.additional_notes
        
        self.view.addSubview(SubTaskTable)
        self.view.backgroundColor? = UIColor(red: 79.0/255.0, green: 43.0/255.0,blue: 53.0/255.0, alpha: 1.0)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        self.SubTaskTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.SubTaskTable.backgroundColor = UIColor(red: 79.0/255.0, green: 43.0/255.0,blue: 53.0/255.0, alpha: 1.0)
        self.SubTaskTable.reloadData()
        
    }

    //delegate methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subTask.count
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let Cell = SubTaskTable.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        let row = indexPath.row
        let subChecked: SubTask = subTask[row]
        
 
        if subChecked.is_checked == true {
            subChecked.is_checked = false
            Cell.accessoryType = .None
        }
        else
        {
            subChecked.is_checked = true
            Cell.accessoryType = .Checkmark
        }
        Cell.CellLabel.text = subTask[row].task_name
        Cell.CellLabel.SetFontSize(20)
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        self.SubTaskTable.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CustomCell {
        
        let Cell = SubTaskTable.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        
        
        let row = indexPath.row
        if row % 2 == 0 {
            Cell.contentView.backgroundColor = UIColor(red: 145.0/255.0, green: 78.0/255.0,blue: 95.0/255.0, alpha: 1.0)
            
        } else {
            Cell.contentView.backgroundColor = UIColor(red: 114.0/255.0, green: 65.0/255.0,blue: 84.0/255.0, alpha: 1.0)
        }
        
        if subTask[row].is_checked == true {
            Cell.contentView.backgroundColor = UIColor(red: 210.0/255.0, green: 82.0/255.0,blue: 127.0/255.0, alpha: 1)
            Cell.tintColor =  UIColor(red: 226.0/255.0, green: 185.0/255.0,blue: 199.0/255.0, alpha: 1.0)
            Cell.accessoryType = .Checkmark
        } else {
            Cell.accessoryType = .None
        }
        Cell.CellLabel.text = subTask[row].task_name

        Cell.layer.backgroundColor =  UIColor(red: 204.0/255.0, green: 204.0/255.0,blue: 204.0/255.0, alpha: 0).CGColor
        Cell.CellLabel.SetFontSize(20)

        return Cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            subTask.removeAtIndex(indexPath.row).MR_deleteEntity()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
}