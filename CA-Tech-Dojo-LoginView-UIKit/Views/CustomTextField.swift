//
//  CustomTextField.swift
//  CA-Tech-Dojo-LoginView-UIKit
//
//  Created by 上條栞汰 on 2023/05/14.
//

import UIKit

final class CustomTextField: UITextField {
    
    init(frame: CGRect, placeholder: String) {
        super.init(frame: frame)
        font = UIFontDefinition.middleSize
        layer.cornerRadius = 10
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        layer.masksToBounds = true
        textColor = .white
        layer.borderColor = UIColor.white.cgColor
        borderStyle = .bezel
        self.placeholder = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
