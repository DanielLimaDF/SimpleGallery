//
//  SimpleGalleryView.swift
//  
//
//  Created by DanielLimaDF on 03/01/21.
//

import Foundation
import SnapKit
import UIKit

internal class SimpleGalleryView: UIView {

    // MARK: - Internal Properties

    internal var viewModel: SimpleGalleryViewModel? {
        didSet {
            update()
        }
    }

    internal let collectionView: UICollectionView
    internal let adapter: SimpleGalleryAdapter

    // MARK: - Private Properties

    private let flowLayout: UICollectionViewFlowLayout

    // MARK: - Life Cycle

    internal required init() {
        flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        adapter = SimpleGalleryAdapter(collectionView: collectionView)
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func update() {
        guard let model = viewModel else {
            return
        }

        adapter.items = model.items
    }

}

extension SimpleGalleryView: ViewCoding {

    func buildHierarchy() {
        addViews(collectionView)
    }

    func setupConstraints() {

        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }

    }

    internal func render() {
        collectionView.backgroundColor = .clear
        backgroundColor = UIColor(red: 0.20, green: 0.24, blue: 0.35, alpha: 1.00)
        flowLayout.itemSize = CGSize(width: ((UIScreen.main.bounds.size.width / 2) - 20), height: ((UIScreen.main.bounds.size.width / 2) - 20))
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
    }

}
