//
//  Add.swift
//  ToDoApp
//
//  Created by Louiz on 07/12/2015.
//  Copyright © 2015 IdeaRobin. All rights reserved.
//

import UIKit
import MagicalRecord

class AddItemListViewController: CustomView {
    
    @IBOutlet weak var MainNavigationItem: UINavigationItem!
    @IBOutlet weak var NewTitleLabel: CustomLabel!
    @IBOutlet weak var TitleTextField: CustomTextField!
    @IBOutlet weak var NoteLabel: CustomLabel!
    @IBOutlet weak var NoteTextField: CustomTextView!

    @IBAction func AddTask(sender: AnyObject) {

        if(TitleTextField.text != "") {
            let Tasks = Task.MR_createEntity() as Task!
    

            Tasks.task = TitleTextField.text!
            Tasks.additional_notes = NoteTextField.text!

            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        MainNavigationItem.title? = LABEL.TODO.ADD_ITEM;
        NewTitleLabel.text! = LABEL.TODO.ADD_LABEL
        NoteLabel.text! = LABEL.TODO.NOTE_LABEL
        NoteTextField.text! = LABEL.TODO.NOTE_TEXT
        NoteTextField.SetBorderWidth(0.2)
        NoteTextField.layer.borderColor = UIColor.grayColor().CGColor
        NoteTextField.layer.cornerRadius = CGRectGetWidth(NoteTextField.frame)/25
        NoteTextField.clipsToBounds = true

        self.view.backgroundColor? = UIColor(red: 79.0/255.0, green: 43.0/255.0,blue: 53.0/255.0, alpha: 1.0)

        
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
