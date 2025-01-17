//
//  PullRequestView.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

final class PullRequestView: UIView {
    private lazy var descriptionView = DescriptionView(title: title, description: descriptionText)
    
    private lazy var avatarView = AvatarView(name: authorName, avatarURL: authorAvatarURL)
    
    private lazy var stateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if let state {
            view.backgroundColor = state == .closed ? .red : .systemGreen
        } else {
            view.backgroundColor = .yellow
        }
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionView, avatarView])
        stackView.axis = .vertical
        stackView.spacing = .smallSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: .smallSpacing, left: .smallSpacing,
                                        bottom: .smallSpacing, right: .smallSpacing)
        return stackView
    }()
    
    private lazy var stateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stateView, stackView])
        stackView.axis = .horizontal
        stackView.spacing = .smallSpacing
        return stackView
    }()
    
    private let title: String
    private let descriptionText: String
    private let authorName: String
    private let authorAvatarURL: URL?
    private let state: PullRequestState?
    
    init(title: String, description: String, authorName: String, authorAvatarURL: URL?, state: PullRequestState?) {
        self.title = title
        self.descriptionText = description
        self.authorName = authorName
        self.authorAvatarURL = authorAvatarURL
        self.state = state
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupView() {
        addSubViewWithAllSideConstraints(stateStackView)
        NSLayoutConstraint.activate([
            stateView.widthAnchor.constraint(equalToConstant: 8)
        ])
    }
}
