
//
//  CustomLabel.swift
//  ToDoApp
//
//  Created by Louiz on 07/12/2015.
//  Copyright © 2015 IdeaRobin. All rights reserved.
//


import UIKit

class CustomLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: LABEL.DEFAULT_FONT, size: CGFloat(LABEL.DEFAULT_FONT_SIZE))
        self.textColor! = UIColor(red: 226.0/255.0, green: 185.0/255.0,blue: 199.0/255.0, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.font = UIFont(name: LABEL.DEFAULT_FONT, size: CGFloat(LABEL.DEFAULT_FONT_SIZE))
        self.textColor! = UIColor(red: 226.0/255.0, green: 185.0/255.0,blue: 199.0/255.0, alpha: 1.0)
    }
    
    func SetFontSize(font_size: CGFloat) {
        self.font = UIFont(name: LABEL.DEFAULT_FONT, size: font_size)
    }

    func SetBorderWidth(border_width: CGFloat) {
        self.layer.borderWidth = border_width
    }
}

