//
//  ViewController.swift
//  Nexd
//
//  Created by Tobias Schröpf on 21.03.20.
//  Copyright © 2020 Tobias Schröpf. All rights reserved.
//

import NexdClient
import RxSwift
import SnapKit
import UIKit
import Validator

class RegistrationViewController: ViewController<RegistrationViewController.ViewModel> {
    struct ViewModel {
        let navigator: ScreenNavigating
    }

    private let disposeBag = DisposeBag()
    private var keyboardObserver: KeyboardObserver?
    private var keyboardDismisser: KeyboardDismisser?
    lazy var logo = UIImageView()

    lazy var scrollView = UIScrollView()

    lazy var email = ValidatingTextField.make(tag: 0,
                                              placeholder: R.string.localizable.registration_placeholder_email(),
                                              icon: R.image.mail1(),
                                              keyboardType: .emailAddress,
                                              validationRules: .email)

    lazy var firstName = ValidatingTextField.make(tag: 1,
                                                  placeholder: R.string.localizable.registration_placeholder_firstName(),
                                                  icon: R.image.person1(),
                                                  validationRules: .firstName)

    lazy var lastName = ValidatingTextField.make(tag: 2,
                                                 placeholder: R.string.localizable.registration_placeholder_lastName(),
                                                 icon: R.image.person1(),
                                                 validationRules: .lastName)

    lazy var password = ValidatingTextField.make(tag: 3,
                                                 placeholder: R.string.localizable.registration_placeholder_password(),
                                                 icon: R.image.lock2(),
                                                 isSecureTextEntry: true,
                                                 validationRules: .password)

    lazy var confirmPassword = ValidatingTextField.make(tag: 4,
                                                        placeholder: R.string.localizable.registration_placeholder_confirm_password(),
                                                        icon: R.image.lock1(),
                                                        isSecureTextEntry: true,
                                                        validationRules: .passwordConfirmation { [weak self] in self?.password.value ?? "" })

    lazy var registerButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardDismisser = KeyboardDismisser(rootView: view)

        view.backgroundColor = .white
        title = R.string.localizable.registration_screen_title()

        setupLayoutConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardObserver = KeyboardObserver.insetting(scrollView: scrollView)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        keyboardObserver = nil
    }

    override func bind(viewModel: RegistrationViewController.ViewModel, disposeBag: DisposeBag) {}

    private func setupLayoutConstraints() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(view)
        }

        contentView.addSubview(logo)
        logo.image = R.image.logo()
        logo.snp.makeConstraints { make -> Void in
            make.size.equalTo(Style.logoSize)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(68)
        }

        contentView.addSubview(email)
        email.snp.makeConstraints { make -> Void in
            make.leftMargin.equalTo(8)
            make.rightMargin.equalTo(-8)
            make.top.equalTo(logo.snp.bottom).offset(134)
        }

        contentView.addSubview(firstName)
        firstName.snp.makeConstraints { make -> Void in
            make.leftMargin.equalTo(8)
            make.rightMargin.equalTo(-8)
            make.top.equalTo(email.snp.bottom).offset(Style.verticalPadding)
        }

        contentView.addSubview(lastName)
        lastName.snp.makeConstraints { make -> Void in
            make.leftMargin.equalTo(8)
            make.rightMargin.equalTo(-8)
            make.top.equalTo(firstName.snp.bottom).offset(Style.verticalPadding)
        }

        contentView.addSubview(password)
        password.snp.makeConstraints { make -> Void in
            make.leftMargin.equalTo(8)
            make.rightMargin.equalTo(-8)
            make.top.equalTo(lastName.snp.bottom).offset(Style.verticalPadding)
        }

        contentView.addSubview(confirmPassword)
        confirmPassword.snp.makeConstraints { make -> Void in
            make.leftMargin.equalTo(8)
            make.rightMargin.equalTo(-8)
            make.top.equalTo(password.snp.bottom).offset(Style.verticalPadding)
        }

        contentView.addSubview(registerButton)
        registerButton.style(text: R.string.localizable.registration_button_title_continue())
        registerButton.addTarget(self, action: #selector(registerButtonPressed(sender:)), for: .touchUpInside)
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(Style.buttonHeight)
            make.leftMargin.equalTo(8)
            make.rightMargin.equalTo(-8)
            make.top.equalTo(confirmPassword.snp.bottom).offset(50)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension RegistrationViewController {
    @objc func registerButtonPressed(sender: UIButton!) {
        let hasInvalidInput = [email, firstName, lastName, password, confirmPassword]
            .map { $0.validate() }
            .contains(false)

        guard !hasInvalidInput else {
            log.warning("Cannot register user! Validation failed!")
            showError(title: R.string.localizable.error_title(), message: R.string.localizable.error_message_registration_validation_failed())
            return
        }

        guard let email = email.value, let firstName = firstName.value, let lastName = lastName.value, let password = password.value else {
            log.warning("Cannot register user, mandatory field is missing!")
            showError(title: R.string.localizable.error_title(), message: R.string.localizable.error_message_registration_validation_failed())
            return
        }

        log.debug("Send registration to backend")
        AuthenticationService.shared.register(email: email,
                                              firstName: firstName,
                                              lastName: lastName,
                                              password: password)
            .subscribe(onCompleted: { [weak self] in
                log.debug("User registration successful")
                let userInformation = UserDetailsViewController.UserInformation(firstName: firstName, lastName: lastName)
                self?.viewModel?.navigator.toUserDetailsScreen(with: userInformation)
            }, onError: { [weak self] error in
                log.error("User registration failed: \(error)")

                if let errorResponse = error as? ErrorResponse, errorResponse.httpStatusCode == .conflict {
                    log.debug("User already exists")
                    self?.showError(title: R.string.localizable.error_title(), message: R.string.localizable.error_message_registration_user_already_exists())
                }

                self?.showError(title: R.string.localizable.error_title(), message: R.string.localizable.error_message_registration_failed())
            })
            .disposed(by: disposeBag)
    }
}
