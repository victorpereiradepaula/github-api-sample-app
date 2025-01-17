//
//  RepositoryView.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

final class RepositoryView: UIView {
    private lazy var avatarView = AvatarView(name: userName, avatarURL: avatarURL)
    
    private lazy var descriptionView = DescriptionView(title: repoName, description: repoDescription)
    
    private lazy var forkInformativeIcon = InformativeIcon(information: forksCount, icon: .init(systemName: "arrow.trianglehead.branch") ?? UIImage())
    
    private lazy var starsInformativeIcon = InformativeIcon(information: starsCount, icon: .init(systemName: "star.fill") ?? UIImage(), iconColor: .orange)
    
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [forkInformativeIcon, starsInformativeIcon, UIView()])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarView, descriptionView, informationStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 16)
        return stackView
    }()
    
    private let userName: String
    private let avatarURL: URL?
    private let repoName: String
    private let repoDescription: String
    private let forksCount: String
    private let starsCount: String
    
    init(userName: String, avatarURL: URL?, repoName: String, repoDescription: String, forksCount: String, starsCount: String) {
        self.userName = userName
        self.avatarURL = avatarURL
        self.repoName = repoName
        self.repoDescription = repoDescription
        self.forksCount = forksCount
        self.starsCount = starsCount
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
