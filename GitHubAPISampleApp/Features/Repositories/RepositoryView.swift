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
        stackView.spacing = .mediumSpacing
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarView, descriptionView, informationStackView])
        stackView.axis = .vertical
        stackView.spacing = .smallSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: .smallSpacing, left: .mediumSpacing,
                                        bottom: .smallSpacing, right: .mediumSpacing)
        return stackView
    }()
    
    private let userName: String
    private let avatarURL: URL?
    private let repoName: String
    private let repoDescription: String
    private let forksCount: String
    private let starsCount: String
    
    convenience init(_ repository: Repository) {
        let user = repository.owner
        self.init(userName: user.name ?? user.login, avatarURL: user.avatarUrl,
                  repoName: repository.name, repoDescription: repository.description,
                  forksCount: "\(repository.forksCount)", starsCount: "\(repository.stargazersCount)")
    }
    
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
        addSubViewWithAllSideConstraints(stackView)
    }
}
