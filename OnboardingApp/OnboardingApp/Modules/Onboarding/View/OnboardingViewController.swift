import UIKit

final class OnboardingViewController: UIViewController {
    
    private let viewModel: OnboardingViewModel
    private let pageViewController: OnboardingPageViewController
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(viewModel.nextButtonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .appPrimary
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(.appSecondaryText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        self.pageViewController = OnboardingPageViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        configurePageViewController()
    }
    
    private func setupUI() {
        view.backgroundColor = .appBackground
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        view.addSubviews(nextButton, closeButton)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupBindings() {
        viewModel.onButtonTitleChanged = { [weak self] title in
            self?.updateButtonTitle(to: title)
        }
        
        viewModel.onDismiss = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        viewModel.onPageIndexChanged = { [weak self] index in
            self?.syncPageViewControllerWithViewModel()
        }
    }
    
    private func configurePageViewController() {
        pageViewController.configure(with: viewModel.pages)
        pageViewController.pageDelegate = self
        
        pageViewController.onScrollProgressChanged = { [weak self] progress, pageIndex in
            guard let self = self else { return }
            if let slideView = self.getCurrentSlideView() {
                slideView.applyParallaxEffect(offset: progress)
            }
        }
    }
    
    private func getCurrentSlideView() -> OnboardingSlideView? {
        guard let currentVC = pageViewController.viewControllers?.first else { return nil }
        return currentVC.view.subviews.first(where: { $0 is OnboardingSlideView }) as? OnboardingSlideView
    }
    
    private func updateButtonTitle(to title: String) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut,
            animations: { [weak self] in
                self?.nextButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            },
            completion: { [weak self] _ in
                self?.nextButton.setTitle(title, for: .normal)
                
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0,
                    usingSpringWithDamping: 0.6,
                    initialSpringVelocity: 0.8,
                    options: .curveEaseOut,
                    animations: {
                        self?.nextButton.transform = .identity
                    }
                )
            }
        )
    }
    
    @objc private func nextButtonTapped() {
        viewModel.didTapNextButton()
    }
    
    @objc private func closeButtonTapped() {
        viewModel.didTapCloseButton()
    }
}

extension OnboardingViewController: OnboardingPageViewControllerDelegate {
    
    func onboardingPageViewController(_ controller: OnboardingPageViewController, didUpdatePageIndex index: Int) {
        if viewModel.currentPageIndex != index {
            viewModel.didScrollToPage(index: index)
        }
    }
    
    private func syncPageViewControllerWithViewModel() {
        let targetIndex = viewModel.currentPageIndex
        if pageViewController.currentPageIndex != targetIndex {
            pageViewController.goToPage(index: targetIndex, animated: true)
        }
    }
}
