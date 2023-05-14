//
//  String-Extension.swift
//  CA-Tech-Dojo-LoginView-UIKit
//
//  Created by 上條栞汰 on 2023/05/14.
//

import Foundation

extension String {
    var isAlphanumeric: Bool {
         let range = "[a-zA-Z0-9]+"
         return NSPredicate(format: "SELF MATCHES %@", range).evaluate(with: self)
     }
}
