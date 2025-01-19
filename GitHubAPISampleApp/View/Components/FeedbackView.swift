//
//  FeedbackView.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

enum FeedbackType {
    case loading
    case message(_ message: String, systemImageName: String, imageColor: UIColor)
}

final class FeedbackView: UIView {
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func addFeedback(to view: UIView, type: FeedbackType) {
        switch type {
        case .loading:
            setupLoading()
        case .message(let message, let systemImageName, let imageColor):
            setupFeedbackWithMessage(message, systemImageName: systemImageName, imageColor: imageColor)
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
    
    private func setupFeedbackWithMessage(_ message: String, systemImageName: String, imageColor: UIColor) {
        backgroundColor = .systemBackground
        
        let imageView = UIImageView(image: .init(systemName: systemImageName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = imageColor
        addSubview(imageView)

        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.text = message
        messageLabel.textColor = .label
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -48),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 48),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
