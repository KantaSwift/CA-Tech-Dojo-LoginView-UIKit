//
//  CustomButton.swift
//  CA-Tech-Dojo-LoginView-UIKit
//
//  Created by 上條栞汰 on 2023/05/14.
//

import UIKit

final class CustomButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? .blue : .init(white: 0.7, alpha: 1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 22, weight: .heavy)
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
