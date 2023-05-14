//
//  LoginViewController.swift
//  CA-Tech-Dojo-LoginView-UIKit
//
//  Created by 上條栞汰 on 2023/05/14.
//

import UIKit
import CombineCocoa
import Combine
import SnapKit

final class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel(repository: SelfRepositoryImpl.shared)
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: UI
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "exchange")?.withTintColor(.lightGray)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome アプリ名!"
        label.font = UIFontDefinition.titleSize
        label.textColor = UIColorDefinition.skyBlue
        return label
    }()
    
    private lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, placeholder: "Name")
        textField.delegate = self
        return textField
    }()
    
    private lazy var twitterIDTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, placeholder: "Twitter ID")
        textField.delegate = self
        return textField
    }()
    
    private lazy var githubNameTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, placeholder: "Github Name")
        textField.delegate = self
        return textField
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Your name"
        label.font = UIFontDefinition.mediumSize
        label.textColor = UIColorDefinition.skyBlue
        return label
    }()
    
    private let twitterIDLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Twitter ID"
        label.font = UIFontDefinition.mediumSize
        label.textColor = UIColorDefinition.skyBlue
        return label
    }()
    
    private let githubNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Github Name"
        label.font = UIFontDefinition.mediumSize
        label.textColor = UIColorDefinition.skyBlue
        return label
    }()
    
    lazy var registerButton: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = .systemBackground
        button.setTitle("register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(white: 0.7, alpha: 1)
        button.isEnabled = false
        return button
    }()
    
    private let accountNameError: UILabel = {
        let label = UILabel()
        label.textColor = UIColorDefinition.lightRed
        return label
    }()
    
    private let twitterIDError: UILabel = {
        let label = UILabel()
        label.textColor = UIColorDefinition.lightRed
        return label
    }()
    
    private let githubNameError: UILabel = {
        let label = UILabel()
        label.textColor = UIColorDefinition.lightRed
        return label
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, accountNameError])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var twitterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [twitterIDLabel, twitterIDTextField, twitterIDError])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var githubStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [githubNameLabel, githubNameTextField, githubNameError])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameStackView, twitterStackView, githubStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        bind()
    }
}

private extension LoginViewController {
    func setupView() {
        view.addSubview(titleImageView)
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(registerButton)
        view.backgroundColor = UIColorDefinition.lightBlack
    }
    
    func setupConstraint() {
        titleImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.height.equalTo(160)
            $0.width.equalTo(200)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        twitterIDTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        githubNameTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
    }
    
    func bind() {
        nameTextField.textPublisher
            .assign(to: &viewModel.$accountName)
        
        twitterIDTextField.textPublisher
            .assign(to: &viewModel.$twitterID)
        
        githubNameTextField.textPublisher
            .assign(to: &viewModel.$githubName)
        
        registerButton.tapPublisher
            .sink { [weak self] _ in
                self?.viewModel.registerButtonTapped.send()
            }
            .store(in: &subscriptions)
    
        viewModel.$isRegisterButtonEnabled
            .sink { [weak self] isValid in
                self?.registerButton.isEnabled = isValid
                self?.registerButton.backgroundColor = isValid ? UIColorDefinition.heavyBlue : .lightGray
            }
            .store(in: &subscriptions)
        
        
        viewModel.selfProfileSubject
            .sink { [weak self] profile in
                let nextVC = NextViewController(profile: profile)
                nextVC.modalPresentationStyle = .fullScreen
                nextVC.modalTransitionStyle = .flipHorizontal
                self?.present(nextVC, animated: true)
            }
            .store(in: &subscriptions)
        
        viewModel.accountNameResult
            .sink { [weak self] result in
                switch result {
                case .valid:
                    self?.accountNameError.text = ""
                case .inValid(let error):
                    self?.accountNameError.text = error.errorDescription
                }
            }
            .store(in: &subscriptions)
        
        viewModel.twitterIDResult
            .sink { [weak self] result in
                switch result {
                case .valid:
                    self?.twitterIDError.text = ""
                case .inValid(let error):
                    self?.twitterIDError.text = error.errorDescription
                }
            }
            .store(in: &subscriptions)
        
        viewModel.githubNameResult
            .sink { [weak self] result in
                switch result {
                case .valid:
                    self?.githubNameError.text = ""
                case .inValid(let error):
                    self?.githubNameError.text = error.errorDescription
                }
            }
            .store(in: &subscriptions)
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 4
        textField.layer.shadowColor = UIColorDefinition.heavyBlue.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.shadowColor = UIColor.clear.cgColor
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
