//
//  LoginViewModel.swift
//  CA-Tech-Dojo-LoginView-UIKit
//
//  Created by 上條栞汰 on 2023/05/14.
//

import Foundation
import Combine
import CombineCocoa

final class LoginViewModel: ObservableObject {
    
    @Published var accountName: String?
    @Published var twitterID: String?
    @Published var githubName: String?
    @Published private(set) var isRegisterButtonEnabled = false
    @Published private(set) var isRegisterButtonHighlighted = false
    
    let registerButtonTapped = PassthroughSubject<Void, Never>()
    let selfProfileSubject = PassthroughSubject<SelfProfile, Never>()
    
//    let nameTextFiledTapped = PassthroughSubject<Void, Never>()
    let accountNameResult = PassthroughSubject<ValidationResult, Never>()
    let twitterIDResult = PassthroughSubject<ValidationResult, Never>()
    let githubNameResult = PassthroughSubject<ValidationResult, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let repository: SelfRepository
    
    init(repository: SelfRepository) {
        self.repository = repository
            
        accountNameResult
            .combineLatest(twitterIDResult, githubNameResult)
            .map { accountNameResult, twitterIDResult, githubNameResult in
                accountNameResult.isValid &&
                twitterIDResult.isValid &&
                githubNameResult.isValid
            }
            .assign(to: &$isRegisterButtonEnabled)
        
        validate(
            publisher: $accountName,
            resultSubject: accountNameResult,
            validator: EmptyValidator.self
        )
        
        validate(
            publisher: $twitterID,
            resultSubject: twitterIDResult,
            validator: SNSValidator.self
        )
        
        validate(
            publisher: $githubName,
            resultSubject: githubNameResult,
            validator: SNSValidator.self
        )
        
        registerButtonTapped
            .sink { [weak self] _ in
                guard let self,
                      let accountName = self.accountName,
                      let twitterID = self.twitterID,
                      let githubName = self.githubName
                else { return }
                self.repository.selfProfile = SelfProfile(accountName: accountName, twitterID: twitterID, githubName: githubName)
                if let profile = self.repository.selfProfile {
                    self.selfProfileSubject.send(profile)
                }
            }
            .store(in: &subscriptions)
    }

    func validate<T: Validator>(
        publisher: Published<String?>.Publisher,
        resultSubject: PassthroughSubject<ValidationResult, Never>,
        validator: T.Type
    ) {
        publisher
            .compactMap { target in
                guard let target else { return nil }
                return T(target: target).validate()
            }
            .sink { result in
                resultSubject.send(result)
            }
            .store(in: &subscriptions)
    }
}

