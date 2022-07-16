import UIKit

class ViewController: UIViewController {

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont(name: "Apple SD Gothic NEO", size: 16)
        label.text = ""
        label.textAlignment = .center
        label.textColor =  #colorLiteral(red: 0.2789022923, green: 0.2789022923, blue: 0.2789022923, alpha: 1)
        label.tintColor =  #colorLiteral(red: 0.5741509199, green: 0.5741508603, blue: 0.5741509199, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your password"
        textField.font = UIFont(name: "Apple SD Gothic NEO", size: 16)
        textField.textColor =  #colorLiteral(red: 0.2789022923, green: 0.2789022923, blue: 0.2789022923, alpha: 1)
        textField.tintColor =  #colorLiteral(red: 0.5741509199, green: 0.5741508603, blue: 0.5741509199, alpha: 1)
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let passwordSelectionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2789022923, green: 0.2789022923, blue: 0.2789022923, alpha: 1), for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(passwordGeneration), for: .touchUpInside)

        return button
    }()

    private let backgroundColorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Press me", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2789022923, green: 0.2789022923, blue: 0.2789022923, alpha: 1), for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backgroundReset), for: .touchUpInside)

        return button
    }()

    @objc func passwordGeneration() {
        let len = 8
        let pswdChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        let rndPswd = String((0..<len).compactMap{ _ in pswdChars.randomElement() })

        passwordTextField.text = rndPswd
    }

    var backColor: Bool = false {
        didSet {
            view.backgroundColor = backColor ? .blue : .red
        }
    }

    @objc func backgroundReset() {
        backColor.toggle()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarhy()
        setupLayout()
    }

    private func setupHierarhy() {
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordSelectionButton)
        view.addSubview(backgroundColorButton)
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

            passwordSelectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordSelectionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            passwordSelectionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            passwordSelectionButton.heightAnchor.constraint(equalToConstant: 50),

            backgroundColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundColorButton.topAnchor.constraint(equalTo: passwordSelectionButton.bottomAnchor, constant: 10),
            backgroundColorButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            backgroundColorButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

