import UIKit

protocol DisplaysThePasswordProtocol {
    func displaysThePasswordLabel(_ password: String)
    func finishPasswordSelection(_ password: String)
    func cancellPasswordSelection(_ password: String)
}

class ViewController: UIViewController {

    var bruteForce = BruteForce(passwordToUnlock: "")
    private let queue = OperationQueue()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont(name: "Apple SD Gothic NEO", size: 20)
        label.text = ""
        label.textAlignment = .left
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.textColor = #colorLiteral(red: 0.2789022923, green: 0.2789022923, blue: 0.2789022923, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your password"
        textField.font = UIFont(name: "Apple SD Gothic NEO", size: 20)
        textField.textColor = #colorLiteral(red: 0.2789022923, green: 0.2789022923, blue: 0.2789022923, alpha: 1)
        textField.tintColor = #colorLiteral(red: 0.5741509199, green: 0.5741508603, blue: 0.5741509199, alpha: 1)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Start", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2789022923, green: 0.2789022923, blue: 0.2789022923, alpha: 1), for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startPasswordSelection), for: .touchUpInside)

        return button
    }()

    private let stopButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Stop", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2789022923, green: 0.2789022923, blue: 0.2789022923, alpha: 1), for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(stopPasswordSelection), for: .touchUpInside)

        return button
    }()

    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.translatesAutoresizingMaskIntoConstraints = false

        return indicator
    }()

    @objc func startPasswordSelection() {
        guard !bruteForce.isExecuting else { return }
        let newPassword = passwordTextField.text ?? ""
        bruteForce = BruteForce(passwordToUnlock: newPassword)
        bruteForce.delegate = self
        queue.addOperation(bruteForce)
        activityIndicator.startAnimating()
    }

    @objc func stopPasswordSelection() {
        if bruteForce.isExecuting {
            bruteForce.cancel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        setupHierarhy()
        setupLayout()
    }

    private func setupHierarhy() {
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(activityIndicator)
    }

    private func setupLayout() {

        NSLayoutConstraint.activate([
            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            passwordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            passwordLabel.heightAnchor.constraint(equalToConstant: 40),

            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),

            startButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            startButton.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            startButton.heightAnchor.constraint(equalToConstant: 50),

            stopButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            stopButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor),
            stopButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            stopButton.heightAnchor.constraint(equalToConstant: 50),

            activityIndicator.topAnchor.constraint(equalTo: passwordLabel.topAnchor),
            activityIndicator.leftAnchor.constraint(equalTo: passwordLabel.rightAnchor, constant: -40),
        ])
    }
}

extension ViewController: DisplaysThePasswordProtocol {

    func cancellPasswordSelection(_ password: String) {
        passwordTextField.isSecureTextEntry = false
        passwordLabel.text = "Пароль не подобран"
        activityIndicator.stopAnimating()
    }

    func finishPasswordSelection(_ password: String) {
        passwordTextField.isSecureTextEntry = false
        passwordLabel.text = password
        activityIndicator.stopAnimating()
    }

    func displaysThePasswordLabel(_ password: String) {
        passwordLabel.text = password
    }
}
