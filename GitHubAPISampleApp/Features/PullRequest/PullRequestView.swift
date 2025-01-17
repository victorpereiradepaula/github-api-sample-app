//
//  PullRequestView.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

final class PullRequestView: UIView {
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .smallSpacing, weight: .light)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var descriptionView = DescriptionView(title: title, description: descriptionText, descriptionNumberOfLines: 5)
    
    private lazy var avatarView = AvatarView(name: authorName, avatarURL: authorAvatarURL)
    
    private lazy var stateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        switch state {
        case .open:
            view.backgroundColor = .systemGreen
        case .closed:
            view.backgroundColor = .red
        case .merged:
            view.backgroundColor = .purple
        case .draft:
            view.backgroundColor = .darkGray
        case .unowned:
            view.backgroundColor = .yellow
        }
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, descriptionView, avatarView])
        stackView.axis = .vertical
        stackView.spacing = .smallSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: .smallSpacing, left: .smallSpacing,
                                        bottom: .mediumSpacing, right: .smallSpacing)
        stackView.setCustomSpacing(.zero, after: dateLabel)
        return stackView
    }()
    
    private lazy var stateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stateView, stackView])
        stackView.axis = .horizontal
        stackView.spacing = .smallSpacing
        return stackView
    }()
    
    private let title: String
    private let descriptionText: String?
    private let authorName: String
    private let authorAvatarURL: URL?
    private let state: PullRequestState
    
    convenience init(_ pullRequest: PullRequest) {
        let author = pullRequest.user
        self.init(title: pullRequest.title, description: pullRequest.body, date: pullRequest.createdAt, authorName: author.name ?? author.login, authorAvatarURL: author.avatarUrl, state: pullRequest.completeState)
    }
    
    init(title: String, description: String?, date: String, authorName: String, authorAvatarURL: URL?, state: PullRequestState) {
        self.title = title
        self.descriptionText = description
        self.authorName = authorName
        self.authorAvatarURL = authorAvatarURL
        self.state = state
        super.init(frame: .zero)
        
        dateLabel.text = date
        
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
