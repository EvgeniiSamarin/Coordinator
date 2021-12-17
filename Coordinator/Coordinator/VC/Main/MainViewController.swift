//
//  MainViewController.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import UIKit
import SnapKit
import Combine

final class MainViewController: UIViewController, MessagePresenting {

    // MARK: - Completion Handler

    var completionHandler: (() -> ())?

    // MARK: - Instance Properties

    private var userSubscriber: AnyCancellable?

    // MARK: -

    private lazy var resetBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetBarButtonPressed))
        return barButtonItem
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = resetBarButtonItem
        view.backgroundColor = .systemBackground
        title = "Random User"
        addSubviews()
        makeConstraints()
        loadActivity()
    }

    // MARK: - Instance Methdos

    private func addSubviews() {
        view.addSubview(label)
        view.addSubview(signOutButton)
    }

    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        signOutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(16)
        }
    }

    @objc
    private func resetBarButtonPressed() {
        loadActivity()
    }

    @objc
    private func signOutButtonPressed() {
        completionHandler?()
    }

    private func loadActivity() {
        self.userSubscriber = APIManager.shared.getRandomCatFact()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.showMessage(withTitle: "Error", message: error.localizedDescription)
                    break

                case .finished:
                    break
                }
            } receiveValue: { user in
                print("---> \(user)")
            }

    }
}

