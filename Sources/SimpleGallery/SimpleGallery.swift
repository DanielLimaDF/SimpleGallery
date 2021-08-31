//
//  SimpleGallery.swift
//  
//
//  Created by DanielLimaDF on 03/01/21.
//

import Foundation
import UIKit

public class SimpleGallery {

    internal let galleryViewController: SimpleGalleryViewController
    internal let galleryNavigationController: UINavigationController
    internal let contentMode: UIImageView.ContentMode

    public init(title: String, pagerColor: UIColor? = nil, selectedPagerColor: UIColor? = nil, galleryImagesContentMode: UIImageView.ContentMode = .scaleAspectFit) {
        contentMode = galleryImagesContentMode
        galleryViewController = SimpleGalleryViewController(contentMode: galleryImagesContentMode, pagerColor: pagerColor, selectedPagerColor: selectedPagerColor)
        galleryViewController.title = title
        galleryNavigationController = UINavigationController(rootViewController: galleryViewController)
    }

    public func present(at viewController: UIViewController, animated: Bool, presentationStyle: UIModalPresentationStyle? = .formSheet) {
        if let style = presentationStyle {
            galleryNavigationController.modalPresentationStyle = style
        }

        viewController.present(galleryNavigationController, animated: animated, completion: nil)
    }

    public func setItems(items: [GalleryItem]) {
        galleryViewController.items = items
    }
    
    public func getFullscreenGallery() -> UIViewController {
        
        guard let items = galleryViewController.items else {
            return DetailPageViewController(items: [], selectedIndex: 0, contentMode: contentMode, pagerColor: galleryViewController.pagerColor, selectedPagerColor: galleryViewController.selectedPagerColor)
        }
        
        let fullscreenGallery = DetailPageViewController(items: items, selectedIndex: 0, contentMode: contentMode, pagerColor: galleryViewController.pagerColor, selectedPagerColor: galleryViewController.selectedPagerColor)
        fullscreenGallery.title = galleryViewController.title
        
        return fullscreenGallery
    }

}
