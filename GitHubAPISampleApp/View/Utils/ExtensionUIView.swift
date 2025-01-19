//
//  ExtensionUIView.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import UIKit

extension UIView {
    func addSubViewWithAllSideConstraints(_ view: UIView, padding: UIEdgeInsets = .zero, isSafeAreaLayoutGuide: Bool = false) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: isSafeAreaLayoutGuide ? safeAreaLayoutGuide.topAnchor : topAnchor,
                                      constant: padding.top),
            view.leadingAnchor.constraint(equalTo: isSafeAreaLayoutGuide ? safeAreaLayoutGuide.leadingAnchor : leadingAnchor,
                                          constant: padding.left),
            view.trailingAnchor.constraint(equalTo: isSafeAreaLayoutGuide ? safeAreaLayoutGuide.trailingAnchor : trailingAnchor,
                                           constant: -padding.right),
            view.bottomAnchor.constraint(equalTo: isSafeAreaLayoutGuide ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor,
                                         constant: -padding.bottom)
        ])
    }
}
