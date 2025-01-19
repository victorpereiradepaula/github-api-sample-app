//
//  FeedbackView.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

enum FeedbackType {
    case loading
    case message(_ message: String, systemImageName: String, imageColor: UIColor, action: FeedbackAction? = nil)
}

final class FeedbackView: UIView {
    
    private var feedbackAction: FeedbackAction?
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func addFeedback(to view: UIView, type: FeedbackType) {
        // Garantir que só haverá um FeedbackView por view
        view.subviews.forEach { if $0 is FeedbackView { $0.removeFromSuperview() } }
        
        switch type {
        case .loading:
            setupLoading()
        case .message(let message, let systemImageName, let imageColor, let action):
            setupFeedbackWithMessage(message, systemImageName: systemImageName, imageColor: imageColor, action: action)
        }
        
        view.addSubViewWithAllSideConstraints(self, isSafeAreaLayoutGuide: true)
    }
    
    private func setupLoading() {
        backgroundColor = .init(white: 0, alpha: 0.75)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    private func setupFeedbackWithMessage(_ message: String, systemImageName: String, imageColor: UIColor, action: FeedbackAction?) {
        backgroundColor = .systemBackground
        
        let imageView = UIImageView(image: .init(systemName: systemImageName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = imageColor
        addSubview(imageView)

        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.text = message
        messageLabel.textColor = .label
        
        let stackView = UIStackView(arrangedSubviews: [messageLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 48
        addSubview(stackView)
        
        if let action {
            self.feedbackAction = action
            let button = UIButton(type: .system)
            button.setTitle(action.title, for: .normal)
            button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -48),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 48),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func didTapActionButton() {
        feedbackAction?.action()
    }
}
