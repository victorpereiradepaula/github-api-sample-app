//
//  TableViewCell.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func setup(_ view: UIView, isCard: Bool = true,
               padding: UIEdgeInsets = .init(top: .smallSpacing, left: .mediumSpacing, bottom: .smallSpacing, right: .mediumSpacing)) {
        selectionStyle = .none
        
        if isCard {
            backgroundColor = .clear
            
            let shadowView = CardView(view)
            contentView.addSubViewWithAllSideConstraints(shadowView, padding: padding)
        } else {
            contentView.addSubViewWithAllSideConstraints(view, padding: padding)
        }
    }
}
