//
//  UIView+addViews.swift
//  
//
//  Created by daniel.da.cunha.lima on 05/01/21.
//

import UIKit

internal extension UIView {

    func addViews(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }

}
