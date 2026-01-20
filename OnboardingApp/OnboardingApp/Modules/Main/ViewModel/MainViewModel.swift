import Foundation

final class MainViewModel {
    
    private let userDefaultsService: UserDefaultsServiceProtocol
    
    var onStateChanged: (() -> Void)?
    var onShowOnboarding: (() -> Void)?
    
    var buttonTitle: String {
        if userDefaultsService.isOnboardingCompleted {
            return "Добро пожаловать обратно"
        } else {
            return "Показать онбординг"
        }
    }
    
    var isOnboardingCompleted: Bool {
        return userDefaultsService.isOnboardingCompleted
    }
    
    init(userDefaultsService: UserDefaultsServiceProtocol = UserDefaultsService.shared) {
        self.userDefaultsService = userDefaultsService
    }
    
    func didTapButton() {
        onShowOnboarding?()
    }
    
    func refreshState() {
        onStateChanged?()
    }
    
    func resetOnboardingState() {
        userDefaultsService.resetAllData()
        onStateChanged?()
    }
}
