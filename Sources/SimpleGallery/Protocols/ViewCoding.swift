//
//  ViewCoding.swift
//  
//
//  Created by daniel.da.cunha.lima on 05/01/21.
//

import Foundation

protocol ViewCoding {
    func configure()
    func buildHierarchy()
    func setupConstraints()
    func render()
}

extension ViewCoding {
    func setupView() {
        configure()
        buildHierarchy()
        setupConstraints()
        render()
    }

    func configure() {}
    func render() {}
}
