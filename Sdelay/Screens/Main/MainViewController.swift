import Combine
import UIKit

// MARK: - Main Screen
class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI components
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Button pressed 0"
        return label
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.setTitle("+", for: .normal)
        return button
    }()

    private lazy var decrementButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.setTitle("-", for: .normal)
        return button
    }()

    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 50
        return stack
    }()
    
    // MARK: - UI lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        addObjectsToView()
        addConstraintsToObjects()
    }
}

private extension MainViewController {
    func configuration() {
        view.backgroundColor = .systemBackground

        self.incrementButton.addAction(UIAction { [weak self] _ in self?.viewModel.increment() }, for: .touchUpInside)
        self.decrementButton.addAction(UIAction { [weak self] _ in self?.viewModel.decrement() }, for: .touchUpInside)

        self.viewModel.$counter
            .sink(receiveValue: { [weak self] value in self?.counterLabel.text = "Button Pressed: \(value)" })
            .store(in: &self.cancellables)
    }

    func addObjectsToView() {
        for item in [self.incrementButton, self.decrementButton] {
            self.buttonsStack.addArrangedSubview(item)
        }

        for item in [self.counterLabel, self.buttonsStack] {
            self.view.addSubview(item)
        }
    }

    func addConstraintsToObjects() {
        NSLayoutConstraint.activate([
            self.counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.counterLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            self.buttonsStack.topAnchor.constraint(equalTo: self.counterLabel.bottomAnchor, constant: 32),
            self.buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            self.buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32)
        ])
    }
}
