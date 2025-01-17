//
//  TableViewCell.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: TableViewCell.self)
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func setup(_ view: UIView, convertViewInCard: Bool = true,
               padding: UIEdgeInsets = .init(top: .smallSpacing, left: .smallSpacing, bottom: .smallSpacing, right: .smallSpacing)) {
        selectionStyle = .none
        
        if convertViewInCard {
            view.backgroundColor = .systemBackground
            view.layer.cornerRadius = 8
            view.clipsToBounds = true
            
            let shadowView = createShadowView()
            contentView.addSubViewWithAllSideConstraints(shadowView, padding: padding)
            shadowView.addSubViewWithAllSideConstraints(view)
        } else {
            contentView.addSubViewWithAllSideConstraints(view, padding: padding)
        }
    }
    
    private func createShadowView() -> UIView {
        let shadowView = UIView()
        shadowView.layer.borderWidth = 0.5
        shadowView.layer.borderColor = UIColor.systemGray4.cgColor
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowRadius = 3.0
        shadowView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return shadowView
    }
}
