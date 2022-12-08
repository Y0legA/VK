// PostLikesControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контрол для отображения и подсчета лайков поста
final class PostLikesControl: UIControl {
    // MARK: - Private Constants

    private enum Constant {
        static let likeButtonImageName = "heart"
        static let dislikeButtonImageName = "heart.fill"
    }

    // MARK: - Private Visual Components

    private let likesButton = UIButton()

    // MARK: - Public Properties

    private var isLiked: Bool = false {
        didSet {
            updateLikeStatus()
        }
    }

    private var likesCount = 0 {
        didSet {
            likesButton.setTitle(String(likesCount), for: .normal)
            UIView.transition(
                with: likesButton.imageView ?? UIImageView(),
                duration: 1.0,
                options: [.transitionCurlUp],
                animations: {
                    self.likesButton.setTitle(String(self.likesCount), for: .normal)
                }
            )
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        confifureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        confifureUI()
    }

    // MARK: - Public Methods

    func configure(_ likes: Int) {
        likesCount = likes
    }

    // MARK: - Private Methods

    @objc private func likeButtonAction(_ sender: UIButton) {
        isLiked.toggle()
    }

    private func confifureUI() {
        setupView()
        setConstraintLikeButton()
        configureLikeButton()
    }

    private func setupView() {
        addSubview(likesButton)
    }

    private func configureLikeButton() {
        likesButton.setImage(UIImage(systemName: Constant.likeButtonImageName), for: .normal)
        likesButton.tintColor = .systemGray
        likesButton.setTitleColor(.systemGray, for: .normal)
        likesButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
    }

    private func setConstraintLikeButton() {
        likesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likesButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            likesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            likesButton.topAnchor.constraint(equalTo: topAnchor),
            likesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
    }

    private func updateLikeStatus() {
        guard isLiked else {
            likesCount -= 1
            likesButton.setImage(UIImage(systemName: Constant.likeButtonImageName), for: .normal)
            return
        }
        likesButton.setImage(UIImage(systemName: Constant.dislikeButtonImageName), for: .normal)
        likesCount += 1
    }
}
