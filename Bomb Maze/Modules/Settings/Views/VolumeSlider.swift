//
//  VolumeSlider.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 30/10/2025.
//

import UIKit

class VolumeSlider: UIView {
    
    var value: Float = 1 {
        didSet {
            updateThumbPosition()
        }
    }
    
    var minimumValue: Float = 0.0
    var maximumValue: Float = 1.0
    
    var onValueChanged: ((Float) -> Void)?
    
    private let trackHeight: CGFloat = 21
    private let innerTrackHeight: CGFloat = 15
    private let thumbSize = CGSize(width: 12, height: 30)
    
    private let trackBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let trackBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let activeTrackView: UIView = {
        let view = UIView()
        view.backgroundColor = .magentaGradientFirst
        return view
    }()
    
    private let thumbView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBordo
        return view
    }()
    
    private var thumbLeadingConstraint: NSLayoutConstraint!
    private var activeTrackWidthConstraint: NSLayoutConstraint!
    private var trackBackgroundHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [
            trackBorderView,
            trackBackgroundView,
            activeTrackView,
            thumbView
        ].forEach(addView)
    }
    
    private func setupConstraints() {
        trackBackgroundHeightConstraint = trackBackgroundView.heightAnchor.constraint(equalToConstant: innerTrackHeight)
        activeTrackWidthConstraint = activeTrackView.widthAnchor.constraint(equalToConstant: 0)
        thumbLeadingConstraint = thumbView.leadingAnchor.constraint(equalTo: leadingAnchor)

        NSLayoutConstraint.activate([
            trackBorderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trackBorderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trackBorderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            trackBorderView.heightAnchor.constraint(equalToConstant: trackHeight),
            
            trackBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            trackBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            trackBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            trackBackgroundHeightConstraint,
            
            activeTrackView.leadingAnchor.constraint(equalTo: trackBackgroundView.leadingAnchor),
            activeTrackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activeTrackView.heightAnchor.constraint(equalToConstant: innerTrackHeight),
            activeTrackWidthConstraint,
            
            thumbLeadingConstraint,
            thumbView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbView.widthAnchor.constraint(equalToConstant: thumbSize.width),
            thumbView.heightAnchor.constraint(equalToConstant: thumbSize.height)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackBorderView.layer.cornerRadius = trackHeight / 2
        trackBackgroundView.layer.cornerRadius = innerTrackHeight / 2
        activeTrackView.layer.cornerRadius = innerTrackHeight / 2
        thumbView.layer.cornerRadius = thumbSize.width / 2
        
        updateThumbPosition()
    }
    
    private func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self)
        updateValue(for: location.x)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        updateValue(for: location.x)
    }
    
    private func updateValue(for xPosition: CGFloat) {
        let trackWidth = bounds.width - thumbSize.width
        let clampedX = max(0, min(xPosition - thumbSize.width / 2, trackWidth))
        let percentage = Float(clampedX / trackWidth)
        
        value = minimumValue + (maximumValue - minimumValue) * percentage
        onValueChanged?(value)
    }
    
    private func updateThumbPosition() {
        guard bounds.width > 0 else { return }
        
        let percentage = CGFloat((value - minimumValue) / (maximumValue - minimumValue))
        let trackWidth = bounds.width - thumbSize.width
        let thumbPosition = percentage * trackWidth
        
        thumbLeadingConstraint.constant = thumbPosition
        
        let borderWidth = (trackHeight - innerTrackHeight) / 2
        let activeWidth = thumbPosition + thumbSize.width / 2
        activeTrackWidthConstraint.constant = max(innerTrackHeight / 2, activeWidth - borderWidth)
        
        layoutIfNeeded()
    }
}
