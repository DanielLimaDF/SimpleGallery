//
//  PictureViewController.swift
//  
//
//  Created by daniel.da.cunha.lima on 07/01/21.
//

import Foundation
import UIKit

internal class PictureViewController: UIViewController {

    let item: GalleryItem
    let contentMode: UIImageView.ContentMode

    internal init(item: GalleryItem, contentMode: UIImageView.ContentMode) {
        self.item = item
        self.contentMode = contentMode
        super.init(nibName: nil, bundle: nil)
    }

    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal override func loadView() {
        view = PictureView(item: item, contentMode: contentMode)
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
    }

}
