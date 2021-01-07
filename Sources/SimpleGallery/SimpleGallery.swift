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

    public init(title: String) {
        galleryViewController = SimpleGalleryViewController()
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

}
