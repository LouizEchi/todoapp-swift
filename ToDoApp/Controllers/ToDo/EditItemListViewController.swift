//
//  EditItemListViewController.swift
//  ToDoApp
//
//  Created by Louiz on 07/12/2015.
//  Copyright © 2015 IdeaRobin. All rights reserved.
//

import UIKit
import MagicalRecord

class EditItemListViewController: CustomView , UITableViewDelegate, UITableViewDataSource {
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
        
        Sub.task_name = SubTaskText.text!
        Sub.is_checked = false
        
        Sub.task = ToDoData!
        

        subTask.append(Sub)

        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
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
        NoteTextField.text! = LABEL.TODO.NOTE_TEXT
        NoteTextField.SetBorderWidth(0.2)
        NoteTextField.layer.borderColor = UIColor.grayColor().CGColor
        NoteTextField.layer.cornerRadius = CGRectGetWidth(NoteTextField.frame)/25
        NoteTextField.clipsToBounds = true
        


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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let Cell = SubTaskTable.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        
        let row = indexPath.row


        //Cell.CellLabel.text = subTask[row].task_name
        
        return Cell
    }

    
    
}