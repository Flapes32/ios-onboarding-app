import XCTest
@testable import OnboardingApp

final class UserDefaultsServiceTests: XCTestCase {
    
    var sut: UserDefaultsService!
    var testUserDefaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        testUserDefaults = UserDefaults(suiteName: "TestUserDefaults")
        testUserDefaults.removePersistentDomain(forName: "TestUserDefaults")
        sut = UserDefaultsService(userDefaults: testUserDefaults)
    }
    
    override func tearDown() {
        testUserDefaults.removePersistentDomain(forName: "TestUserDefaults")
        testUserDefaults = nil
        sut = nil
        super.tearDown()
    }
    
    func testIsOnboardingCompleted_DefaultValue_ReturnsFalse() {
        let result = sut.isOnboardingCompleted
        XCTAssertFalse(result, "По умолчанию isOnboardingCompleted должен быть false")
    }
    
    func testSetOnboardingCompleted_SetToTrue_ReturnsTrue() {
        sut.setOnboardingCompleted(true)
        XCTAssertTrue(sut.isOnboardingCompleted, "После установки в true, isOnboardingCompleted должен вернуть true")
    }
    
    func testSetOnboardingCompleted_SetToFalseAfterTrue_ReturnsFalse() {
        sut.setOnboardingCompleted(true)
        sut.setOnboardingCompleted(false)
        XCTAssertFalse(sut.isOnboardingCompleted, "После установки в false, isOnboardingCompleted должен вернуть false")
    }
    
    func testResetAllData_AfterSettingValues_ReturnsDefaultValues() {
        sut.setOnboardingCompleted(true)
        XCTAssertTrue(sut.isOnboardingCompleted)
        sut.resetAllData()
        XCTAssertFalse(sut.isOnboardingCompleted, "После сброса данных isOnboardingCompleted должен быть false")
    }
    
    func testDataPersistence_AcrossServiceInstances() {
        sut.setOnboardingCompleted(true)
        let newServiceInstance = UserDefaultsService(userDefaults: testUserDefaults)
        XCTAssertTrue(newServiceInstance.isOnboardingCompleted, "Данные должны сохраняться между экземплярами сервиса")
    }
}
