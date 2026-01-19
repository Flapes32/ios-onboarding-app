import UIKit

// MARK: - Добавление нескольких subviews
extension UIView {
    /// Добавляет несколько subviews за один вызов
    /// - Parameter views: Массив views для добавления
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

// MARK: - Настройка Auto Layout
extension UIView {
    /// Отключает autoresizing mask и включает Auto Layout
    func enableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Привязывает view ко всем краям родителя
    /// - Parameter padding: Отступы от краёв (по умолчанию 0)
    func pinToEdges(of superview: UIView, padding: CGFloat = 0) {
        enableAutoLayout()
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding)
        ])
    }
    
    /// Привязывает view ко всем краям Safe Area родителя
    func pinToSafeArea(of superview: UIView, padding: CGFloat = 0) {
        enableAutoLayout()
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    /// Центрирует view в родителе
    func centerInSuperview() {
        guard let superview = superview else { return }
        enableAutoLayout()
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
    
    /// Устанавливает размер view
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
