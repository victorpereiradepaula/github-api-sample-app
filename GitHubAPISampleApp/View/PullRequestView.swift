//
//  PullRequestView.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

final class PullRequestView: UIView {
    private lazy var descriptionView = DescriptionView(title: title, description: descriptionText)
    
    private lazy var avatarView = AvatarView(name: name, avatarURL: avatarURL)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionView, avatarView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 16)
        return stackView
    }()
    
    private let title: String
    private let descriptionText: String
    private let name: String
    private let avatarURL: URL?
    
    init(title: String, description: String, name: String, avatarURL: URL?) {
        self.title = title
        self.descriptionText = description
        self.name = name
        self.avatarURL = avatarURL
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
