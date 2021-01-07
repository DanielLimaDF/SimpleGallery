//
//  SimpleGalleryAdapter.swift
//  
//
//  Created by daniel.da.cunha.lima on 05/01/21.
//

import Foundation
import UIKit

protocol SimpleGalleryAdapterDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

internal class SimpleGalleryAdapter: NSObject {

    internal var items: [GalleryItem]? {
        didSet {
            update()
        }
    }

    internal weak var delegate: SimpleGalleryAdapterDelegate?

    private let collectionView: UICollectionView

    internal init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView.register(cellType: GalleryCellView.self)
        super.init()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    private func update() {
        collectionView.reloadData()
    }

}

extension SimpleGalleryAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GalleryCellView = collectionView.dequeueReusableCell(for: indexPath)

        if let item = items?[indexPath.row] {
            cell.galleryItem = item
        }

        return cell
    }

}

extension SimpleGalleryAdapter: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }

}
