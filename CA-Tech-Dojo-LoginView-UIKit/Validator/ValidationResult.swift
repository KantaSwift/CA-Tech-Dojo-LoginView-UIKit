//
//  ValidationResult.swift
//  CA-Tech-Dojo-LoginView-UIKit
//
//  Created by 上條栞汰 on 2023/05/14.
//

import Foundation

enum ValidationResult: Comparable {
    case valid
    case inValid(ValidationError)

    static func < (lhs: ValidationResult, rhs: ValidationResult) -> Bool {
        if case .inValid(let lhsError) = lhs,
           case .inValid(let rhsError) = rhs {
            return lhsError.rawValue < rhsError.rawValue
        }
        return true
    }
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .valid:
            return true
        case .inValid:
            return false
        }
    }
}
