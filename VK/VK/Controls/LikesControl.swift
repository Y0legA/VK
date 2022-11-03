// LikesControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Контрол для отображения и подсчета лайков
class LikesControl: UIControl {
    // MARK: - Private Constants

    private enum Constant {
        static let likeButtonImageName = "heart"
        static let dislikeButtonImageName = "heart.fill"
    }

    // MARK: - Private Visual Components

    private let likesCountLabel = UILabel()
    private let likeButton = UIButton()

    // MARK: - Public Properties

    var isLiked: Bool = false {
        didSet {
            updateLikeStatus()
        }
    }

    var likesCount = 0 {
        didSet {
            likesCountLabel.text = String(likesCount)
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

    func configure(_ likes: Int, _ isLike: Bool) {
        likesCount = likes
        isLiked = isLike
    }

    // MARK: - Private Methods

    @objc private func likeButtonAction(_ sender: UIButton) {
        isLiked.toggle()
    }

    private func confifureUI() {
        setupView()
        setConstraintLikesCountButton()
        setConstraintLikeButton()
        configureLikeButton()
    }

    private func setupView() {
        addSubview(likeButton)
        addSubview(likesCountLabel)
    }

    private func configureLikeButton() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeButtonAction))
        likeButton.addGestureRecognizer(tapGestureRecognizer)
    }

    private func setConstraintLikesCountButton() {
        likesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likesCountLabel.rightAnchor.constraint(equalTo: likeButton.leftAnchor, constant: -5),
            likesCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setConstraintLikeButton() {
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            likeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            likeButton.widthAnchor.constraint(equalTo: widthAnchor),
            likeButton.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }

    private func setLike() {
        likeButton.setImage(UIImage(systemName: Constant.dislikeButtonImageName), for: .normal)
        likeButton.tintColor = .systemRed
        likesCountLabel.textColor = .systemRed
    }

    private func setdisLike() {
        likeButton.setImage(UIImage(systemName: Constant.likeButtonImageName), for: .normal)
        likeButton.tintColor = .systemGray
        likesCountLabel.textColor = .systemGray
    }

    private func updateLikeStatus() {
        guard isLiked else {
            likesCount -= 1
            setdisLike()
            return
        }
        setLike()
        likesCount += 1
    }
}
