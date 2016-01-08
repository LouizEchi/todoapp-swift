//
//  HomeViewController.swift
//  ToDoApp
//
//  Created by Louiz on 07/12/2015.
//  Copyright © 2015 IdeaRobin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
 
    @IBOutlet weak var TitleLabel: CustomLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleLabel.text! = LABEL.HOME.TITLE
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
