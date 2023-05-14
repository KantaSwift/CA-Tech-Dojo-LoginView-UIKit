//
//  ValidationError.swift
//  CA-Tech-Dojo-LoginView-UIKit
//
//  Created by 上條栞汰 on 2023/05/14.
//

import Foundation

enum ValidationError: Int, LocalizedError {
    case alphabet
    case isEmpty
}

extension ValidationError {
    public var errorDescription: String? {
        switch self {
        case .isEmpty:
            return "入力されていない欄があります"
        case .alphabet:
            return "各アカウント情報は英語で入力してください"
        }
    }
}
