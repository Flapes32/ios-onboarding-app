import UIKit

struct OnboardingPage {
    let image: UIImage?
    let title: String
    let description: String
    let backgroundColor: UIColor?
    
    init(
        image: UIImage?,
        title: String,
        description: String,
        backgroundColor: UIColor? = nil
    ) {
        self.image = image
        self.title = title
        self.description = description
        self.backgroundColor = backgroundColor
    }
    
    init(
        imageName: String,
        title: String,
        description: String,
        backgroundColor: UIColor? = nil
    ) {
        self.image = UIImage(named: imageName)
        self.title = title
        self.description = description
        self.backgroundColor = backgroundColor
    }
    
    init(
        systemImageName: String,
        title: String,
        description: String,
        backgroundColor: UIColor? = nil
    ) {
        self.image = UIImage(systemName: systemImageName)?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 100, weight: .light))
        self.title = title
        self.description = description
        self.backgroundColor = backgroundColor
    }
}

extension OnboardingPage {
    static let samplePages: [OnboardingPage] = [
        OnboardingPage(
            imageName: "onboarding-1",
            title: "Добро пожаловать!",
            description: "Мы рады видеть вас в нашем приложении. Давайте познакомимся с основными функциями."
        ),
        OnboardingPage(
            imageName: "onboarding-2",
            title: "Избранное",
            description: "Сохраняйте понравившиеся элементы в избранное для быстрого доступа к ним."
        ),
        OnboardingPage(
            imageName: "onboarding-3",
            title: "Уведомления",
            description: "Включите уведомления, чтобы не пропустить важные обновления и новости."
        )
    ]
}
