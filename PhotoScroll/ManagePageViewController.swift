/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/
import UIKit

class ManagePageViewController: UIViewController, UIPageViewControllerDataSource {
  @IBOutlet weak var pageController: UIPageViewController!
  var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
  var currentIndex: Int!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Get pages from storyboard
    if let storyboard = storyboard, uiPageController = storyboard.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController {
      pageController = uiPageController
      pageController.dataSource = self
      if let viewController = viewPhotoCommentController(currentIndex ?? 0) {
        let viewControllers = [viewController]
        pageController.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        addChildViewController(pageController)
        view.addSubview(pageController.view)
        pageController.didMoveToParentViewController(self)
      }
    }
  }
  
  func viewPhotoCommentController(index: Int) -> PhotoCommentViewController? {
    if let storyboard = storyboard, page = storyboard.instantiateViewControllerWithIdentifier("PhotoCommentViewController") as? PhotoCommentViewController {
      page.photoName = photos[index]
      page.photoIndex = index
      return page
    }
    return nil
  }
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    }
}

//MARK: implementation of UIPageViewControllerDataSource
extension ManagePageViewController {
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    if let viewController = viewController as? PhotoCommentViewController {
      var index = viewController.photoIndex
      guard index != NSNotFound && index != 0 else { return nil }
      index = index - 1
      return viewPhotoCommentController(index)
    }
    return nil
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    if let viewController = viewController as? PhotoCommentViewController {
      var index = viewController.photoIndex
      guard index != NSNotFound else { return nil }
      index = index + 1
      guard index != photos.count else {return nil}
      return viewPhotoCommentController(index)
    }
    return nil
  }
  
  // MARK: UIPageControl
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return photos.count
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return currentIndex ?? 0
  }
}