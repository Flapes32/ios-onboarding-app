import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func enableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func pinToEdges(of superview: UIView, padding: CGFloat = 0) {
        enableAutoLayout()
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding)
        ])
    }
    
    func pinToSafeArea(of superview: UIView, padding: CGFloat = 0) {
        enableAutoLayout()
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    func centerInSuperview() {
        guard let superview = superview else { return }
        enableAutoLayout()
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
    
    func setSize(width: CGFloat? = nil, height: CGFloat? = nil) {
        enableAutoLayout()
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
