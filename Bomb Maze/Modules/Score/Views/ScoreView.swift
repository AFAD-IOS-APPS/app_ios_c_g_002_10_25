//
//  ScoreView.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 27/10/2025.
//

import UIKit

enum GameResult {
    case win
    case lost
}

final class ScoreView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appLavender
        view.clipsToBounds = true
        view.layer.cornerRadius = 35
        return view
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 14
        return stackView
    }()
    
    private let scoreImageView = UIImageView()
    
    private let scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR SCORE:"
        label.textAlignment = .center
        label.font = .chalkboard(size: 22)
        label.textColor = .darkBlue
        return label
    }()
    
    private let scoreAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .sfPro(size: 21)
        label.textColor = .appMagenta
        return label
    }()
    
    private let scoreCapsuleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .scoreCapsule
        return imageView
    }()
    
    private let rewardTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "REWARD:"
        label.textAlignment = .center
        label.font = .chalkboard(size: 22)
        label.textColor = .darkBlue
        return label
    }()
    
    private let rewardAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .sfPro(size: 21)
        label.textColor = .appMagenta
        return label
    }()
    
    private let rewardCapsuleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .scoreCapsule
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ScoreViewModel) {
        scoreAmountLabel.text = String(model.score)
        configureTextAttachment(with: model.reward)
        
        scoreImageView.image = switch model.gameResult {
        case .win:
                .win
        case .lost:
                .lost
        }
    }
    
    private func setupViews() {
        scoreCapsuleImageView.addView(scoreAmountLabel)
        rewardCapsuleImageView.addView(rewardAmountLabel)
        [
            scoreImageView,
            scoreTitleLabel,
            scoreCapsuleImageView,
            rewardTitleLabel,
            rewardCapsuleImageView
        ].forEach(containerStackView.addArrangedSubview)
        containerView.addView(containerStackView)
        
        addView(containerView)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 28),
            containerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -28),
            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28),
            containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -28),
                        
            scoreCapsuleImageView.heightAnchor.constraint(equalToConstant: 38),
            scoreCapsuleImageView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor),
            rewardCapsuleImageView.heightAnchor.constraint(equalToConstant: 38),
            rewardCapsuleImageView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor),
            
            scoreAmountLabel.centerXAnchor.constraint(equalTo: scoreCapsuleImageView.centerXAnchor),
            scoreAmountLabel.centerYAnchor.constraint(equalTo: scoreCapsuleImageView.centerYAnchor),
            
            rewardAmountLabel.centerXAnchor.constraint(equalTo: rewardCapsuleImageView.centerXAnchor),
            rewardAmountLabel.centerYAnchor.constraint(equalTo: rewardCapsuleImageView.centerYAnchor),
        ])
    }
    
    private func configureTextAttachment(with rewardAmount: Int) {
        let attachment = NSTextAttachment()
        attachment.image = .star
        attachment.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let priceString = NSAttributedString(string: " \(rewardAmount)", attributes: [
            .font: UIFont.sfPro(size: 21),
            .foregroundColor: UIColor(resource: .appMagenta)
        ])
        
        let combined = NSMutableAttributedString()
        combined.append(attachmentString)
        combined.append(priceString)
        
        rewardAmountLabel.attributedText = combined
    }
}
