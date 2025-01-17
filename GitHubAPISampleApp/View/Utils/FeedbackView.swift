//
//  FeedbackView.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

final class FeedbackView: UIView {
    enum FeedbackType {
        case loading
        case error(_ message: String)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func addFeedback(to view: UIView, type: FeedbackType) {
        subviews.forEach { $0.removeFromSuperview() }
        
        switch type {
        case .loading:
            setupLoading()
        case .error(let message):
            setupError(message)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
    
    private func setupError(_ message: String) {
        backgroundColor = .white
        
        let errorImageView = UIImageView(image: .init(systemName: "exclamationmark.circle"))
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        errorImageView.tintColor = .systemRed
        addSubview(errorImageView)

        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.text = message
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            errorImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -48),
            errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImageView.widthAnchor.constraint(equalToConstant: 48),
            errorImageView.heightAnchor.constraint(equalTo: errorImageView.widthAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -24)
        ])
    }
}
