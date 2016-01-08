//
//  CustomView.swift
//  ToDoApp
//
//  Created by Louiz on 06/01/2016.
//  Copyright © 2016 IdeaRobin. All rights reserved.
//

import UIKit

class CustomView: UIViewController {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 140.0/255.0, green: 73.0/255.0,blue: 91.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 226.0/255.0, green: 185.0/255.0,blue: 199.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: LABEL.DEFAULT_FONT, size: CGFloat(LABEL.DEFAULT_FONT_NAV_SIZE))!,NSForegroundColorAttributeName: UIColor(red: 226.0/255.0, green: 185.0/255.0,blue: 199.0/255.0, alpha: 1.0)]
    }
        
}