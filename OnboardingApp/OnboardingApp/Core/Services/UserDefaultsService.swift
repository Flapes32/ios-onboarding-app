import Foundation

final class UserDefaultsService: UserDefaultsServiceProtocol {
    
    static let shared = UserDefaultsService()
    
    private enum Keys {
        static let isOnboardingCompleted = "isOnboardingCompleted"
    }
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var isOnboardingCompleted: Bool {
        return userDefaults.bool(forKey: Keys.isOnboardingCompleted)
    }
    
    func setOnboardingCompleted(_ completed: Bool) {
        userDefaults.set(completed, forKey: Keys.isOnboardingCompleted)
        userDefaults.synchronize()
        
        #if DEBUG
        print("✅ [UserDefaultsService] Onboarding completed set to: \(completed)")
        #endif
    }
    
    func resetAllData() {
        userDefaults.removeObject(forKey: Keys.isOnboardingCompleted)
        userDefaults.synchronize()
        
        #if DEBUG
        print("🗑️ [UserDefaultsService] All data has been reset")
        #endif
    }
}
