//
//  GalleryCellView.swift
//  
//
//  Created by daniel.da.cunha.lima on 05/01/21.
//

import Foundation
import Kingfisher
import Reusable
import UIKit

internal final class GalleryCellView: UICollectionViewCell, Reusable {

    internal var galleryItem: GalleryItem? {
        didSet {
            update()
        }
    }

    private let imageView: UIImageView
    private let videoImageView: UIImageView

    internal override init(frame: CGRect) {
        imageView = UIImageView()
        videoImageView = UIImageView()
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func update() {
        if let item = galleryItem {

            videoImageView.isHidden = item.type == .picture
            imageView.kf.setImage(with: item.imageURL)

        }
    }

}

extension GalleryCellView: ViewCoding {

    func buildHierarchy() {
        addViews(imageView, videoImageView)
    }

    func setupConstraints() {

        imageView.frame = CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width / 2) - 36, height: (UIScreen.main.bounds.width / 2) - 36)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        videoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(imageView.frame.width / 2.5)
            make.left.equalToSuperview().inset(imageView.frame.width / 2.5)
            make.right.equalToSuperview().inset(imageView.frame.width / 2.5)
            make.bottom.equalToSuperview().inset(imageView.frame.width / 2.5)
        }

    }

    internal func render() {
        videoImageView.image = UIImage(named: "play", in: Bundle.module, compatibleWith: nil)
        videoImageView.isHidden = true

        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = (6 / 100) * imageView.frame.width
        imageView.contentMode = .scaleAspectFill
    }

}
