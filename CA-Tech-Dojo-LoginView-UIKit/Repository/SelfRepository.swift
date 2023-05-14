//
//  SelfRepository.swift
//  CA-Tech-Dojo-LoginView-UIKit
//
//  Created by 上條栞汰 on 2023/05/14.
//

import Foundation
import Combine

protocol SelfRepository: AnyObject {
    var selfProfile: SelfProfile? { get set }
}

final class SelfRepositoryImpl: SelfRepository {
    static let shared = SelfRepositoryImpl()
    private init() {}
    
    private let selfProfileSubject = PassthroughSubject<SelfProfile, Never>()
    
    var selfProfile: SelfProfile? {
        get {
            guard let data = UserDefaults.standard.data(forKey: "selfProfile") else {
                return nil
            }
            let profile = try? JSONDecoder().decode(SelfProfile.self, from: data)
            return profile
        }
        set {
            guard
                let newValue,
                let data = try? JSONEncoder().encode(newValue)
            else { return }
            
            UserDefaults.standard.setValue(data, forKey: "selfProfile")
            selfProfileSubject.send(newValue)
        }
    }
}
