//
//  CardView.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 19/01/25.
//

import UIKit

final class CardView: UIView {
    private let view: UIView
    
    init(_ view: UIView) {
        self.view = view
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = .defaultCornerRadius
        view.clipsToBounds = true
        
        addSubViewWithAllSideConstraints(view)
        setupShadow()
    }

    private func setupShadow() {
        layer.cornerRadius = .defaultCornerRadius
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray3.cgColor
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3.0
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }
}
