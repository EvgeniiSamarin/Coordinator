//
//  StartViewController.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import UIKit
import SnapKit

final class StartViewController: UIViewController, FlowController, MessagePresenting {

    // MARK: - CompletionHandler

    var completionHandler: ((SelectedStartFlow) -> ())?

    // MARK: - Instance Properties

    private lazy var loginInput: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter Login"
        view.borderStyle = .roundedRect
        return view
    }()

    private lazy var passwordInput: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter Password"
        view.isSecureTextEntry = true
        view.borderStyle = .roundedRect
        return view
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot password", for: .normal)
        button.addTarget(self, action: #selector(forgotButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginInput, passwordInput, nextButton, forgotPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Instance Methods

    @objc
    private func signInButtonPressed() {
        guard let password = passwordInput.text,
              let login = loginInput.text,
              !password.isEmpty && !login.isEmpty
        else {
            self.showMessage(withTitle: "Invalid credentinals", message: "Password and Login must not be empty")
            return
        }
        completionHandler?(.main)
    }

    @objc
    private func forgotButtonPressed() {
        completionHandler?(.forgotPassword)
    }
}

