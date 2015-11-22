//
//  ViewController.swift
//  PhotoScroll
//
//  Created by Corinne Krych on 21/11/15.
//  Copyright © 2015 raywenderlich. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    private let reuseIdentifier = "PhotoCell"
    private let thumnailSize:CGFloat = 75.0
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 10.0, bottom: 50.0, right: 10.0)
    private let photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UICollectionViewCell, indexPath = collectionView!.indexPathForCell(cell) {

            let theDestination = (segue.destinationViewController as! PhotoViewController)
            theDestination.photoName = photos[indexPath.row]
        }
    }

}

// MARK: Implementation of UICollectionViewDataSource
extension ViewController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCell
        cell.backgroundColor = UIColor.blackColor()

        let thumbnail = showThumbnail(UIImage(named:photos[indexPath.row])!, thumnailSize: thumnailSize)
        cell.imageView.image = thumbnail
        return cell
    }
}

// MARK: Implementation of UICollectionViewDelegateFlowLayout
extension ViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: thumnailSize, height: thumnailSize)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }

}

func showThumbnail(image: UIImage, thumnailSize: CGFloat)-> UIImage {
    UIGraphicsBeginImageContext(CGSize(width: thumnailSize, height: thumnailSize))
    let rect = CGRectMake(0.0, 0.0, thumnailSize, thumnailSize)
    UIGraphicsBeginImageContext(rect.size)
    image.drawInRect(rect)
    let thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext()
    return thumbnail
}
