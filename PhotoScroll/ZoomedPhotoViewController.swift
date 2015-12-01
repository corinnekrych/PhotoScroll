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

class ZoomedPhotoViewController: UIViewController {
  var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  var photoName: String!
  
  @IBAction func close(sender: AnyObject) {
    self.dismissViewControllerAnimated(false, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // 1
    let image = UIImage(named: photoName)!
    imageView = UIImageView(image: image)
    imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:image.size)
    scrollView.addSubview(imageView)
    
    // 2
    scrollView.contentSize = image.size
    
    // 3
    let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
    doubleTapRecognizer.numberOfTapsRequired = 2
    doubleTapRecognizer.numberOfTouchesRequired = 1
    scrollView.addGestureRecognizer(doubleTapRecognizer)
    
    // 4
    let scrollViewFrame = scrollView.frame
    let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
    let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
    let minScale = min(scaleWidth, scaleHeight);
    scrollView.minimumZoomScale = minScale;
    
    // 5
    scrollView.maximumZoomScale = 1.0
    scrollView.zoomScale = minScale;
    
    // 6
    centerScrollViewContents()
  }
  
  func centerScrollViewContents() {
    let boundsSize = scrollView.bounds.size
    var contentsFrame = imageView.frame
    
    if contentsFrame.size.width < boundsSize.width {
      contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
    } else {
      contentsFrame.origin.x = 0.0
    }
    
    if contentsFrame.size.height < boundsSize.height {
      contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
    } else {
      contentsFrame.origin.y = 0.0
    }
    
    imageView.frame = contentsFrame
  }
  
  func scrollViewDidZoom(scrollView: UIScrollView) {
    centerScrollViewContents()
  }
  
  func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
    // 1
    let pointInView = recognizer.locationInView(imageView)
    
    // 2
    var newZoomScale = scrollView.zoomScale * 1.5
    newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
    
    // 3
    let scrollViewSize = scrollView.bounds.size
    let w = scrollViewSize.width / newZoomScale
    let h = scrollViewSize.height / newZoomScale
    let x = pointInView.x - (w / 2.0)
    let y = pointInView.y - (h / 2.0)
    
    let rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    scrollView.zoomToRect(rectToZoomTo, animated: true)
  }
}

// MARK: - UIScrollViewDelegate
extension ZoomedPhotoViewController: UIScrollViewDelegate {
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return imageView
  }

}

