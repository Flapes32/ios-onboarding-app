import UIKit

final class OnboardingSlideView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .appText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .appSecondaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var imageViewCenterXConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with page: OnboardingPage) {
        imageView.image = page.image
        titleLabel.text = page.title
        descriptionLabel.text = page.description
        
        if let backgroundColor = page.backgroundColor {
            self.backgroundColor = backgroundColor
        } else {
            self.backgroundColor = .appBackground
        }
    }
    
    func applyParallaxEffect(offset: CGFloat) {
        let parallaxMultiplier: CGFloat = 30
        imageViewCenterXConstraint?.constant = -offset * parallaxMultiplier
        
        let scale = 1 - abs(offset) * 0.1
        imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    private func setupUI() {
        addSubviews(imageView, textStackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageViewCenterXConstraint = imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            imageViewCenterXConstraint!,
            imageView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.6),
            imageView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.35),
            
            textStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            textStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            textStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
}
