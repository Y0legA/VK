// TextField+Extention.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UITextField {
    func setWallsPadingPoints(_ amoint: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amoint, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
        rightView = paddingView
        rightViewMode = .always
    }
}
