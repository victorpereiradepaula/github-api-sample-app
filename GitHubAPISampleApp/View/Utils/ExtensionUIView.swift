//
//  ExtensionUIView.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import UIKit

extension UIView {
    func addSubViewWithAllSideConstraints(_ view: UIView, padding: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: padding.top),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom)
        ])
    }
}
