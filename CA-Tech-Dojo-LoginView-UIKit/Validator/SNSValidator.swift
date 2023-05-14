//
//  ProfileValidator.swift
//  CA-Tech-Dojo-LoginView-UIKit
//
//  Created by 上條栞汰 on 2023/05/14.
//

import Foundation

protocol Validator {
    var target: String { get }
    func validate() -> ValidationResult
    init(target: String)
}

struct AlphabetValidator: Validator {
    let target: String
    
    init(target: String) {
        self.target = target
    }
    
    func validate() -> ValidationResult {
        guard target.isAlphanumeric else {
            return .inValid(.alphabet)
        }
        return .valid
    }
}

struct EmptyValidator: Validator {
    let target: String
    
    init(target: String) {
        self.target = target
    }
    
    func validate() -> ValidationResult {
        guard !target.isEmpty else {
            return .inValid(.isEmpty)
        }
        return .valid
    }
}

struct SNSValidator: Validator {
    let target: String
    
    init(target: String) {
        self.target = target
    }
    
    func validate() -> ValidationResult {
        let validators: [Validator] = [
            AlphabetValidator(target: target),
            EmptyValidator(target: target)
        ]
        let result = validators
            .map({ $0.validate() })
            .sorted(by: { $0 > $1 })
            .first(where: { !$0.isValid })
        guard let result else {
            return .valid
        }
        return result
    }
}
