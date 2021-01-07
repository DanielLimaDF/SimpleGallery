//
//  VideoViewController.swift
//  
//
//  Created by daniel.da.cunha.lima on 07/01/21.
//

import Foundation
import UIKit

internal class VideoViewController: UIViewController {

    let item: GalleryItem

    internal init(item: GalleryItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal override func loadView() {
        view = VideoView(item: item)
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
    }

}
