import UIKit

final class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Главный экран"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(viewModel.buttonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .appPrimary
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сбросить онбординг", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.appSecondaryText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshState()
        
        if !viewModel.isOnboardingCompleted {
            showOnboarding()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .appBackground
        
        view.addSubviews(titleLabel, actionButton, resetButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupBindings() {
        viewModel.onStateChanged = { [weak self] in
            self?.updateUI()
        }
        
        viewModel.onShowOnboarding = { [weak self] in
            self?.showOnboarding()
        }
    }
    
    private func updateUI() {
        actionButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    @objc private func buttonTapped() {
        viewModel.didTapButton()
    }
    
    @objc private func resetButtonTapped() {
        viewModel.resetOnboardingState()
    }
    
    private func showOnboarding() {
        let onboardingViewModel = OnboardingViewModel()
        let onboardingViewController = OnboardingViewController(viewModel: onboardingViewModel)
        onboardingViewController.modalPresentationStyle = .fullScreen
        present(onboardingViewController, animated: true)
    }
}
