//
//  CustomButton.swift
//  ToDoApp
//
//  Created by Louiz on 06/01/2016.
//  Copyright © 2016 IdeaRobin. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel!.font = UIFont(name: LABEL.DEFAULT_FONT, size: CGFloat(LABEL.DEFAULT_FONT_SIZE))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.titleLabel!.font = UIFont(name: LABEL.DEFAULT_FONT, size: CGFloat(LABEL.DEFAULT_FONT_SIZE))
    }
    
    func SetFontSize(font_size: CGFloat) {
        self.titleLabel!.font = UIFont(name: LABEL.DEFAULT_FONT, size: font_size)
    }
    
}