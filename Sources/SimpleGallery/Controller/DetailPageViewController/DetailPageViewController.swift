//
//  DetailPageViewController.swift
//  
//
//  Created by daniel.da.cunha.lima on 07/01/21.
//

import Foundation
import UIKit

internal class DetailPageViewController: UIPageViewController {

    private let viewControllersList: [UIViewController]
    private let presentationIndex: Int

    internal init(items: [GalleryItem], selectedIndex: Int) {
        presentationIndex = selectedIndex
        viewControllersList = items.map { $0.type == .picture ? PictureViewController(item: $0) : VideoViewController(item: $0) }
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        setViewControllers([viewControllersList[selectedIndex]], direction: .forward, animated: true, completion: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        setupAppearaance()
    }

    internal func setupAppearaance() {
        view.backgroundColor = UIColor(red: 0.20, green: 0.24, blue: 0.35, alpha: 1.00)
    }

}

extension DetailPageViewController: UIPageViewControllerDataSource {

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllersList.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return presentationIndex
    }

    internal func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = viewControllersList.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = currentIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard viewControllersList.count > previousIndex else {
            return nil
        }

        return viewControllersList[previousIndex]

    }

    internal func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = viewControllersList.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = currentIndex + 1
        let totalControllers = viewControllersList.count

        guard totalControllers != nextIndex else {
            return nil
        }

        guard totalControllers > nextIndex else {
            return nil
        }

        return viewControllersList[nextIndex]

    }

}
