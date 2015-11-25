//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by Corinne Krych on 24/11/15.
//  Copyright © 2015 raywenderlich. All rights reserved.
//

import UIKit

public class PhotoCommentViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var email: UITextField!
    
    public var photoName: String!
    public var photoIndex: Int!
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        email.endEditing(true)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        if (photoName != nil) {
            self.imageView.image = UIImage(named: photoName)
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }
    
    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let adjustmentHeight = (CGRectGetHeight(keyboardFrame) + 20) * (show ? 1 : -1)
        
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }

    @IBAction func openZoomingController(sender: AnyObject) {
        if sender.state == UIGestureRecognizerState.Ended {
            self.performSegueWithIdentifier("zooming", sender: nil)
        }
    }
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier {
            if id == "zooming" {
            let theDestination = segue.destinationViewController as! PhotoViewController
            theDestination.photoName = photoName
            }
        }

    }
}
