//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by Corinne Krych on 25/11/15.
//  Copyright © 2015 raywenderlich. All rights reserved.
//

import UIKit

class ManagePageViewController: UIViewController, UIPageViewControllerDataSource {
    @IBOutlet weak var pageController: UIPageViewController!
    var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create data model images
        
        // Get pages
        pageController = storyboard!.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        pageController.dataSource = self
        
        let startingViewController:PhotoCommentViewController = self.viewPhotoCommentController(0)
        let viewControllers = [startingViewController]
        self.pageController.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        
        // Change the size of page view controller
        self.pageController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        self.addChildViewController(pageController)
        self.view.addSubview(pageController.view)
        self.pageController.didMoveToParentViewController(self)
    }
    
    func viewPhotoCommentController(index: Int) -> PhotoCommentViewController {
        let photoCommentController = storyboard!.instantiateViewControllerWithIdentifier("PhotoCommentViewController") as! PhotoCommentViewController
        photoCommentController.photoName = photos[index]
        photoCommentController.photoIndex = index
        return photoCommentController
    }
    
    //MARK: implementation of UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PhotoCommentViewController).photoIndex
        
        if ((index == 0) || (index == NSNotFound))  {
            return nil
        }
        
        index = index - 1
        return self.viewPhotoCommentController(index)
    
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PhotoCommentViewController).photoIndex
        
        if (index == NSNotFound) {
            return nil
        }
        
        index = index + 1
        if (index == photos.count) {
           return nil;
        }
        return self.viewPhotoCommentController(index)
    }
    
/*
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    }
*/
}
