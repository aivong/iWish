//
//  iWishStylingTool.swift
//  iWish
//
//  Created by Kevin French on 4/21/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class iWishStylingTool {
    
    class func addStyleToSubviewsOfView(view: UIView) {
        
        if view.subviews.count == 0 {
            return
        }
        
        for subview in view.subviews {
            
            addStyleToSubviewsOfView(subview as UIView)
            
            if subview is UILabel {
                addStyleToLabel(subview as UILabel)
            } else if subview is UITextField {
                addStyleToTextField(subview as UITextField)
            } else if subview is UITextView {
                addStyleToTextView(subview as UITextView)
            } else if subview is UISwitch {
                addStyleToSwitch(subview as UISwitch)
            } else if subview is UITableViewCell {
                addStyleToTableViewCell(subview as UITableViewCell)
            } else if subview is UIButton {
//                addStyleToButton(subview as UIButton)
            }
        }

    }
    
    class func addStyleToLabel(label: UILabel) {
        label.font = UIFont(name: "Heiti SC", size: 14.0)
    }
    
    class func addStyleToTextField(textField: UITextField) {
        textField.font = UIFont(name: "Heiti SC", size: 14.0)
        textField.backgroundColor = UIColor(red: 252.0/255.0, green: 80.0/255.0, blue:80.0/255.0, alpha: 1.0)
    }
    
    class func addStyleToTextView(textView: UITextView) {
        textView.font = UIFont(name: "Heiti SC", size: 14.0)
        textView.backgroundColor = UIColor(red: 252.0/255.0, green: 80.0/255.0, blue:80.0/255.0, alpha: 1.0)
    }
    
    class func addStyleToSwitch(_switch: UISwitch) {
        _switch.onTintColor = UIColor(red: 252.0/255.0, green: 80.0/255.0, blue:80.0/255.0, alpha: 1.0)
    }
    
    class func addStyleToTableViewCell(cell: UITableViewCell) {
        cell.textLabel?.font = UIFont(name: "Heiti SC", size: 14.0)
        cell.detailTextLabel?.font = UIFont(name: "Heiti SC", size: 10.0)
    }
    
    class func addStyleToButton(button: UIButton) {
        button.layer.borderColor = UIColor(red: 252.0/255.0, green: 80.0/255.0, blue:80.0/255.0, alpha: 1.0).CGColor
        button.layer.borderWidth = 1.0
        button.titleLabel?.font = UIFont(name: "Heiti SC", size: 14.0)
    }
}
