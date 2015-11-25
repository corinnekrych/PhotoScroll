//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by Corinne Krych on 24/11/15.
//  Copyright © 2015 raywenderlich. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        email.endEditing(true)
    }

}
