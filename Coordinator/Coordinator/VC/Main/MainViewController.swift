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

    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender:"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First name:"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last name:"
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

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genderLabel, firstNameLabel, lastNameLabel, signOutButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
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
        view.addSubview(stackView)
    }

    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
        var urlRequest = URLRequest(url: URL(string: "https://randomuser.me/api/")!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
//        self.userSubscriber = URLSession.shared.dataTaskPublisher(for: urlRequest)
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//                switch completion {
//                case .failure(let error):
//                    self.showMessage(withTitle: "Error", message: error.localizedDescription)
//                    break
//
//                case .finished:
//                    break
//                }
//            } receiveValue: { user in
//                guard let data = try? JSONSerialization.jsonObject(with: user.data, options: .allowFragments) as? [String: Any] else {
//                    return
//                }
//                guard let results = data["results"] as? [String: Any] else {
//                    return
//                }
//                for (key, value) in results {
//                    print("\(key) -> \(value) \n")
//                }
//            }
        self.userSubscriber = APIManager.shared.getRandomUser()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.showMessage(withTitle: "Error", message: error.localizedDescription)
                    break

                case .finished:
                    break
                }
            } receiveValue: { [weak self] user in
                self?.firstNameLabel.text = "GENDER: \(user.results?.name?.first ?? "")"
                self?.lastNameLabel.text = "firstName: \(user.results?.name?.last ?? "")"
                self?.genderLabel.text = "firstName: \(user.results?.name?.last ?? "")"
            }

    }
}

