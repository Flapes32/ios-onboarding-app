import XCTest
@testable import OnboardingApp

final class OnboardingViewModelTests: XCTestCase {
    
    var sut: OnboardingViewModel!
    var mockUserDefaultsService: MockUserDefaultsService!
    var testPages: [OnboardingPage]!
    
    override func setUp() {
        super.setUp()
        mockUserDefaultsService = MockUserDefaultsService()
        testPages = [
            OnboardingPage(systemImageName: "1.circle", title: "Page 1", description: "Desc 1"),
            OnboardingPage(systemImageName: "2.circle", title: "Page 2", description: "Desc 2"),
            OnboardingPage(systemImageName: "3.circle", title: "Page 3", description: "Desc 3")
        ]
        sut = OnboardingViewModel(pages: testPages, userDefaultsService: mockUserDefaultsService)
    }
    
    override func tearDown() {
        sut = nil
        mockUserDefaultsService = nil
        testPages = nil
        super.tearDown()
    }
    
    func testInitialState_CurrentPageIndexIsZero() {
        XCTAssertEqual(sut.currentPageIndex, 0)
    }
    
    func testInitialState_NumberOfPagesEqualsInputPages() {
        XCTAssertEqual(sut.numberOfPages, testPages.count)
    }
    
    func testInitialState_IsNotLastPage() {
        XCTAssertFalse(sut.isLastPage)
    }
    
    func testInitialState_NextButtonTitleIsDalee() {
        XCTAssertEqual(sut.nextButtonTitle, "Далее")
    }
    
    func testDidScrollToPage_UpdatesCurrentPageIndex() {
        sut.didScrollToPage(index: 1)
        XCTAssertEqual(sut.currentPageIndex, 1)
    }
    
    func testGoToPage_UpdatesCurrentPageIndex() {
        sut.goToPage(index: 2)
        XCTAssertEqual(sut.currentPageIndex, 2)
    }
    
    func testGoToPage_InvalidIndex_DoesNotUpdate() {
        sut.goToPage(index: 100)
        XCTAssertEqual(sut.currentPageIndex, 0)
    }
    
    func testIsLastPage_OnLastPage_ReturnsTrue() {
        sut.goToPage(index: testPages.count - 1)
        XCTAssertTrue(sut.isLastPage)
    }
    
    func testNextButtonTitle_OnLastPage_ReturnsNachatRabotu() {
        sut.goToPage(index: testPages.count - 1)
        XCTAssertEqual(sut.nextButtonTitle, "Начать работу")
    }
    
    func testDidTapNextButton_OnLastPage_SavesCompletionAndDismisses() {
        sut.goToPage(index: testPages.count - 1)
        var didDismiss = false
        sut.onDismiss = { didDismiss = true }
        
        sut.didTapNextButton()
        
        XCTAssertTrue(mockUserDefaultsService.isOnboardingCompleted)
        XCTAssertTrue(didDismiss)
    }
    
    func testDidTapCloseButton_OnLastPage_SavesCompletionAndDismisses() {
        sut.goToPage(index: testPages.count - 1)
        var didDismiss = false
        sut.onDismiss = { didDismiss = true }
        
        sut.didTapCloseButton()
        
        XCTAssertTrue(mockUserDefaultsService.isOnboardingCompleted)
        XCTAssertTrue(didDismiss)
    }
    
    func testDidTapCloseButton_NotOnLastPage_DoesNotSaveCompletion() {
        var didDismiss = false
        sut.onDismiss = { didDismiss = true }
        
        sut.didTapCloseButton()
        
        XCTAssertFalse(mockUserDefaultsService.isOnboardingCompleted)
        XCTAssertTrue(didDismiss)
    }
    
    func testOnPageChanged_CalledWhenPageChanges() {
        var receivedIndex: Int?
        sut.onPageChanged = { index in
            receivedIndex = index
        }
        
        sut.goToPage(index: 1)
        
        XCTAssertEqual(receivedIndex, 1)
    }
    
    func testOnButtonTitleChanged_CalledWhenPageChanges() {
        var receivedTitle: String?
        sut.onButtonTitleChanged = { title in
            receivedTitle = title
        }
        
        sut.goToPage(index: testPages.count - 1)
        
        XCTAssertEqual(receivedTitle, "Начать работу")
    }
}

final class MockUserDefaultsService: UserDefaultsServiceProtocol {
    var isOnboardingCompleted: Bool = false
    
    func setOnboardingCompleted(_ completed: Bool) {
        isOnboardingCompleted = completed
    }
    
    func resetAllData() {
        isOnboardingCompleted = false
    }
}
