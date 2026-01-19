import Foundation

protocol UserDefaultsServiceProtocol {
    var isOnboardingCompleted: Bool { get }
    func setOnboardingCompleted(_ completed: Bool)
    func resetAllData()
}
