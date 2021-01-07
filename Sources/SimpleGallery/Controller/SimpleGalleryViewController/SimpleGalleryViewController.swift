//
//  SimpleGalleryViewController.swift
//  
//
//  Created by DanielLimaDF on 03/01/21.
//

import Foundation
import UIKit

internal class SimpleGalleryViewController: UIViewController {

    internal var items: [GalleryItem]? {
        didSet {
            updateItems()
        }
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }

    override func loadView() {
        let galleryView = SimpleGalleryView()
        galleryView.adapter.delegate = self
        view = galleryView
    }

    private func setupNavigation() {
        let navBarAppearance = UINavigationBar.appearance()
        var backButton: UIBarButtonItem

        if #available(iOS 13.0, *) {
            backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: self, action: #selector(close))
        } else {
            backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(close))
        }

        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.20, green: 0.24, blue: 0.35, alpha: 1.00)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = backButton

    }

    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }

    private func updateItems() {
        guard let galleryItems = items else {
            return
        }

        let model = SimpleGalleryViewModel(items: galleryItems)
        (view as? SimpleGalleryView)?.viewModel = model
    }

}

extension SimpleGalleryViewController: SimpleGalleryAdapterDelegate {

    func didSelectItem(at index: Int) {
        guard let galleryItems = items else {
            return
        }

        let detailViewController = DetailPageViewController(items: galleryItems, selectedIndex: index)
        detailViewController.title = title
        navigationController?.pushViewController(detailViewController, animated: true)

    }

}
