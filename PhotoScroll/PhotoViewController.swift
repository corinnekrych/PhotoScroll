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
        //scrollView.minimumZoomScale = 0.1
        //scrollView.maximumZoomScale = 3.0
        //scrollView.zoomScale = 1.0
    }
    
    func setZoomParametersForSize(scrollViewSize: CGSize) {
        let imageSize = imageView.bounds.size
        
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
    }
    
    override func viewWillLayoutSubviews() {
        setZoomParametersForSize(scrollView.bounds.size)
        recenterImage()
    }
    
    func recenterImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.frame.size
        var tabSize: CGFloat = 0
        if let navigationController = navigationController {
            tabSize = CGRectGetHeight(navigationController.navigationBar.frame)
        }
        let horizontalSpace = imageSize.width < scrollViewSize.width ?
            (scrollViewSize.width - imageSize.width) / 2 : 0
        let verticalSpace = imageSize.height < scrollViewSize.height ?
            (scrollViewSize.height - tabSize - imageSize.height) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalSpace,
            left: horizontalSpace,
            bottom: verticalSpace,
            right: horizontalSpace)
    }
}

// MARK: - UIScrollViewDelegate
extension PhotoViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

