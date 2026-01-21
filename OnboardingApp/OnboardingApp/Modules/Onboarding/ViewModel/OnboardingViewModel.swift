import Foundation

final class OnboardingViewModel {
    
    private let userDefaultsService: UserDefaultsServiceProtocol
    
    let pages: [OnboardingPage]
    
    private(set) var currentPageIndex: Int = 0 {
        didSet {
            onPageChanged?(currentPageIndex)
            onButtonTitleChanged?(nextButtonTitle)
            onPageIndexChanged?(currentPageIndex)
        }
    }
    
    var numberOfPages: Int {
        return pages.count
    }
    
    var isLastPage: Bool {
        return currentPageIndex == pages.count - 1
    }
    
    var nextButtonTitle: String {
        return isLastPage ? "Начать работу" : "Далее"
    }
    
    var currentPage: OnboardingPage? {
        guard currentPageIndex < pages.count else { return nil }
        return pages[currentPageIndex]
    }
    
    var onPageChanged: ((Int) -> Void)?
    var onDismiss: (() -> Void)?
    var onButtonTitleChanged: ((String) -> Void)?
    var onPageIndexChanged: ((Int) -> Void)?
    
    init(
        pages: [OnboardingPage] = OnboardingPage.samplePages,
        userDefaultsService: UserDefaultsServiceProtocol = UserDefaultsService.shared
    ) {
        self.pages = pages
        self.userDefaultsService = userDefaultsService
    }
    
    func didTapNextButton() {
        if isLastPage {
            completeOnboarding()
        } else {
            let nextIndex = currentPageIndex + 1
            guard nextIndex < pages.count else { return }
            currentPageIndex = nextIndex
        }
    }
    
    func didTapCloseButton() {
        if isLastPage {
            completeOnboarding()
        } else {
            onDismiss?()
        }
    }
    
    func didScrollToPage(index: Int) {
        guard index >= 0, index < pages.count else { return }
        currentPageIndex = index
    }
    
    func goToPage(index: Int) {
        guard index >= 0, index < pages.count else { return }
        currentPageIndex = index
    }
    
    private func goToNextPage() {
        guard currentPageIndex < pages.count - 1 else { return }
        currentPageIndex += 1
    }
    
    private func completeOnboarding() {
        userDefaultsService.setOnboardingCompleted(true)
        onDismiss?()
    }
}
