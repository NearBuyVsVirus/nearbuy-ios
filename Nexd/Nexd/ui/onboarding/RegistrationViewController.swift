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
    private let caShapeLayer = CAShapeLayer()
    private var didAgreeTermsOfUse: Bool = false
    
    lazy var scrollView = UIScrollView()

    lazy var email = ValidatingTextField.make(tag: 0,
                                              placeholder: R.string.localizable.registration_placeholder_email(),
                                              keyboardType: .emailAddress,
                                              validationRules: .email())

    lazy var firstName = ValidatingTextField.make(tag: 1,
                                                  placeholder: R.string.localizable.registration_placeholder_firstName(),
                                                  validationRules: .firstName())

    lazy var lastName = ValidatingTextField.make(tag: 2,
                                                 placeholder: R.string.localizable.registration_placeholder_lastName(),
                                                 validationRules: .lastName())

    lazy var password = ValidatingTextField.make(tag: 3,
                                                 placeholder: R.string.localizable.registration_placeholder_password(),
                                                 isSecureTextEntry: true,
                                                 validationRules: .password())

    lazy var confirmPassword = ValidatingTextField.make(tag: 4,
                                                        placeholder: R.string.localizable.registration_placeholder_confirm_password(),
                                                        isSecureTextEntry: true,
                                                        validationRules: .passwordConfirmation(dynamicTarget: { [weak self] in self?.password.value ?? "" }))

    private lazy var emailImageView = UIImageView()

    private lazy var firstNameImageView = UIImageView()

    private lazy var lastNameImageView = UIImageView()

    private lazy var passwordImageView = UIImageView()

    private lazy var confirmPasswordImageView = UIImageView()
    
    lazy var privacyPolicy = UITextView()
    
    lazy var confirmTermsOfUseButton = UIButton()

    lazy var registerButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardDismisser = KeyboardDismisser(rootView: view)
        didAgreeTermsOfUse = false
        view.backgroundColor = .white
        title = R.string.localizable.registration_screen_title()
        setupImageViews()
        confirmTermsOfUseButton.addTarget(self, action: #selector(confirmTermsOfUseButtonPressed), for: .touchUpInside)
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
    
    override func viewDidLayoutSubviews() {
        drawCircle(on: confirmTermsOfUseButton)
    }

    override func bind(viewModel: RegistrationViewController.ViewModel, disposeBag: DisposeBag) {

    }

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
            make.top.equalTo(logo.snp.bottom).offset(80)
        }

        contentView.addSubview(emailImageView)
        emailImageView.snp.makeConstraints { make -> Void in
            make.centerY.equalTo(email.snp_centerY).offset(-7.5)
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.right.equalToSuperview().offset(-41)
        }

        contentView.addSubview(firstName)
        firstName.snp.makeConstraints { make -> Void in
            make.leftMargin.equalTo(8)
            make.rightMargin.equalTo(-8)
            make.top.equalTo(email.snp.bottom).offset(Style.verticalPadding)
        }

        contentView.addSubview(firstNameImageView)
        firstNameImageView.snp.makeConstraints { make -> Void in
            make.centerY.equalTo(firstName.snp_centerY).offset(-7.5)
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.right.equalToSuperview().offset(-41)
        }

        contentView.addSubview(lastName)
        lastName.snp.makeConstraints { make -> Void in
            make.leftMargin.equalTo(8)
            make.rightMargin.equalTo(-8)
            make.top.equalTo(firstName.snp.bottom).offset(Style.verticalPadding)
        }

        contentView.addSubview(lastNameImageView)
        lastNameImageView.snp.makeConstraints { make -> Void in
            make.centerY.equalTo(lastName.snp_centerY).offset(-7.5)
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.right.equalToSuperview().offset(-41)
        }

        contentView.addSubview(password)
        password.snp.makeConstraints { make -> Void in
            make.leftMargin.equalTo(8)
            make.rightMargin.equalTo(-8)
            make.top.equalTo(lastName.snp.bottom).offset(Style.verticalPadding)
        }

        contentView.addSubview(passwordImageView)
        passwordImageView.snp.makeConstraints { make -> Void in
            make.centerY.equalTo(password.snp_centerY).offset(-7.5)
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.right.equalToSuperview().offset(-41)
        }

        contentView.addSubview(confirmPassword)
        confirmPassword.snp.makeConstraints { make -> Void in
            make.leftMargin.equalTo(8)
            make.rightMargin.equalTo(-8)
            make.top.equalTo(password.snp.bottom).offset(Style.verticalPadding)
        }

        contentView.addSubview(confirmPasswordImageView)
        confirmPasswordImageView.snp.makeConstraints { make -> Void in
            make.centerY.equalTo(confirmPassword.snp_centerY).offset(-7.5)
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.right.equalToSuperview().offset(-41)
        }
        contentView.addSubview(privacyPolicy)
        privacyPolicy.backgroundColor = .clear
        privacyPolicy.isScrollEnabled = false
        privacyPolicy.textContainerInset = .zero

        let term = R.string.localizable.registration_term_privacy_policy()
        let formatted = R.string.localizable.registration_label_privacy_policy_agreement(term)
        privacyPolicy.attributedText = formatted.asLink(range: formatted.range(of: term), target: "https://www.nexd.app/privacypage")
        privacyPolicy.snp.makeConstraints { make -> Void in
            make.height.equalTo(54)
            make.rightMargin.equalTo(-8)
            make.top.equalTo(confirmPassword.snp.bottom).offset(12)
        }

        contentView.addSubview(confirmTermsOfUseButton)
        confirmTermsOfUseButton.snp.makeConstraints { make -> Void in
            make.centerY.equalTo(privacyPolicy.snp_centerY).offset(-7.5)
            make.left.equalToSuperview().offset(27)
            make.right.equalTo(privacyPolicy.snp.left).offset(-9)
            make.height.equalTo(26)
            make.width.equalTo(26)
        }
        contentView.addSubview(registerButton)
        registerButton.style(text: R.string.localizable.registration_button_title_continue())
        registerButton.addTarget(self, action: #selector(registerButtonPressed(sender:)), for: .touchUpInside)
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(Style.buttonHeight)
            make.leftMargin.equalTo(8)
            make.rightMargin.equalTo(-8)
           make.top.equalTo(confirmPassword.snp.bottom).offset(80)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    private func setupImageViews() {
        emailImageView.image = R.image.mail1()
        emailImageView.contentMode = .scaleAspectFit

        firstNameImageView.image = R.image.person1()
        firstNameImageView.contentMode = .scaleAspectFit

        lastNameImageView.image = R.image.person1()
        lastNameImageView.contentMode = .scaleAspectFit

        passwordImageView.image = R.image.lock2()
        passwordImageView.contentMode = .scaleAspectFit

        confirmPasswordImageView.image = R.image.lock1()
        confirmPasswordImageView.contentMode = .scaleAspectFit
    }
    private func drawCircle(on button: UIButton) {
        let buttonWidth = button.frame.size.width
        let buttonHeight = button.frame.size.height

        let centerCoordinates = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)

        let smallestAspect = min(button.frame.width, button.frame.height)
        let circleRadiusWithinButton = smallestAspect / 2

        // prevents setting the layer when the constraints have not been set properly yet
        if buttonWidth != 0, buttonHeight != 0, circleRadiusWithinButton != 0 {
            let circularPath = UIBezierPath(arcCenter: centerCoordinates,
                                            radius: circleRadiusWithinButton,
                                            startAngle: 0,
                                            endAngle: 2 * CGFloat.pi,
                                            clockwise: true)
            caShapeLayer.path = circularPath.cgPath
            caShapeLayer.strokeColor = R.color.nexdGreen()?.cgColor
            caShapeLayer.lineWidth = 3.0
            caShapeLayer.fillColor  = UIColor.clear.cgColor
            button.layer.addSublayer(caShapeLayer)
        }
    }
}

extension RegistrationViewController {
    @objc func confirmTermsOfUseButtonPressed() {
        if caShapeLayer.fillColor == UIColor.clear.cgColor {
            caShapeLayer.fillColor = R.color.nexdGreen()?.cgColor
        } else {
            caShapeLayer.fillColor = UIColor.clear.cgColor
        }
        didAgreeTermsOfUse = !didAgreeTermsOfUse
    }
    @objc func registerButtonPressed(sender: UIButton!) {
        let hasInvalidInput = [email, firstName, lastName, password, confirmPassword]
            .map { $0.validate() }
            .contains(false)

        guard didAgreeTermsOfUse else {
            log.warning("Cannot update user, did not agree to privacy policy")
            showError(title: R.string.localizable.error_title(), message: R.string.localizable.error_message_registration_failed())
            return
        }
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

                self?.showError(title: R.string.localizable.error_title(), message: R.string.localizable.error_message_registration_failed())
            })
            .disposed(by: disposeBag)
    }
}

private extension ValidationRuleSet where InputType == String {
    enum ValidationErrors: String, ValidationError {
        case emailInvalid = "Email address is invalid!"
        case missingFirstName = "Frist name must not be empty!"
        case missingLastName = "Last name must not be empty!"
        case passwordTooShort = "Password is too short!"
        case passwordConfirmationFailed = "Passwords do not match!"
        var message: String { return rawValue }
    }

    static func email() -> ValidationRuleSet<String> {
        ValidationRuleSet(rules: [ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationErrors.emailInvalid)])
    }

    static func firstName() -> ValidationRuleSet<String> {
        ValidationRuleSet<String>(rules: [ValidationRuleLength(min: 1, error: ValidationErrors.missingFirstName)])
    }

    static func lastName() -> ValidationRuleSet<String> {
        ValidationRuleSet<String>(rules: [ValidationRuleLength(min: 1, error: ValidationErrors.missingLastName)])
    }

    static func password() -> ValidationRuleSet<String> {
        ValidationRuleSet<String>(rules: [ValidationRuleLength(min: 5, error: ValidationErrors.passwordTooShort)])
    }

    static func passwordConfirmation(dynamicTarget: @escaping (() -> String)) -> ValidationRuleSet<String> {
        ValidationRuleSet<String>(rules: [ValidationRuleEquality<String>(dynamicTarget: dynamicTarget,
                                                                         error: ValidationErrors.passwordConfirmationFailed)])
    }
}
