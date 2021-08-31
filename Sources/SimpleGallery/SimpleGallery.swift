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

    public init(title: String, pagerColor: UIColor? = nil, selectedPagerColor: UIColor? = nil) {
        galleryViewController = SimpleGalleryViewController()
        galleryViewController.title = title
        galleryViewController.pagerColor = pagerColor
        galleryViewController.selectedPagerColor = selectedPagerColor
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
            return DetailPageViewController(items: [], selectedIndex: 0, pagerColor: galleryViewController.pagerColor, selectedPagerColor: galleryViewController.selectedPagerColor)
        }
        
        let fullscreenGallery = DetailPageViewController(items: items, selectedIndex: 0, pagerColor: galleryViewController.pagerColor, selectedPagerColor: galleryViewController.selectedPagerColor)
        fullscreenGallery.title = galleryViewController.title
        
        return fullscreenGallery
    }

}
