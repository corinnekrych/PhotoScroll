//
//  PhotoViewController.swift
//  PhotoScroll
//
//  Created by Corinne Krych on 22/11/15.
//  Copyright © 2015 raywenderlich. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var photoName: String!
    
    override func viewDidLoad() {
        imageView.image = UIImage(named: photoName)
    }
}