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
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  var photoName: String!
  
  override func viewDidLoad() {
    imageView.image = UIImage(named: photoName)
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
extension ZoomedPhotoViewController: UIScrollViewDelegate {
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return imageView
  }
}

