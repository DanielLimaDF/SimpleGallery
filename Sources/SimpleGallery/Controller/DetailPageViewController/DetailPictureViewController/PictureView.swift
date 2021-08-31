//
//  PictureView.swift
//  
//
//  Created by daniel.da.cunha.lima on 07/01/21.
//

import Foundation
import UIKit

internal class PictureView: UIView {

    let galleryItem: GalleryItem
    let imageView: UIImageView

    internal init(item: GalleryItem) {
        galleryItem = item
        imageView = UIImageView()
        super.init(frame: .zero)
        setupView()
    }

    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PictureView: ViewCoding {

    func buildHierarchy() {
        addViews(imageView)
    }

    func setupConstraints() {

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }

    }

    internal func render() {
        backgroundColor = UIColor(red: 0.20, green: 0.24, blue: 0.35, alpha: 1.00)
        imageView.contentMode = .scaleAspectFill
        imageView.kf.setImage(with: galleryItem.imageURL)
    }

}
