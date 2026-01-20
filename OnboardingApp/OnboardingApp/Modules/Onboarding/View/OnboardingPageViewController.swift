import UIKit

protocol OnboardingPageViewControllerDelegate: AnyObject {
    func onboardingPageViewController(_ controller: OnboardingPageViewController, didUpdatePageIndex index: Int)
}

final class OnboardingPageViewController: UIPageViewController {
    
    weak var pageDelegate: OnboardingPageViewControllerDelegate?
    
    private var pages: [OnboardingPage] = []
    private var pageViewControllers: [UIViewController] = []
    
    private(set) var currentPageIndex: Int = 0
    
    init() {
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        view.backgroundColor = .appBackground
    }
    
    func configure(with pages: [OnboardingPage]) {
        self.pages = pages
        
        pageViewControllers = pages.map { page in
            let viewController = UIViewController()
            let slideView = OnboardingSlideView()
            slideView.configure(with: page)
            
            viewController.view.addSubview(slideView)
            slideView.pinToEdges(of: viewController.view)
            
            return viewController
        }
        
        if let firstViewController = pageViewControllers.first {
            setViewControllers(
                [firstViewController],
                direction: .forward,
                animated: false,
                completion: nil
            )
        }
    }
    
    func goToPage(index: Int, animated: Bool = true) {
        guard index >= 0, index < pageViewControllers.count else { return }
        
        let direction: UIPageViewController.NavigationDirection = index > currentPageIndex ? .forward : .reverse
        
        setViewControllers(
            [pageViewControllers[index]],
            direction: direction,
            animated: animated,
            completion: { [weak self] _ in
                self?.currentPageIndex = index
                self?.pageDelegate?.onboardingPageViewController(self!, didUpdatePageIndex: index)
            }
        )
    }
    
    func goToNextPage() {
        let nextIndex = currentPageIndex + 1
        guard nextIndex < pageViewControllers.count else { return }
        goToPage(index: nextIndex)
    }
    
    func goToPreviousPage() {
        let previousIndex = currentPageIndex - 1
        guard previousIndex >= 0 else { return }
        goToPage(index: previousIndex)
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = pageViewControllers.firstIndex(of: viewController),
              currentIndex > 0 else {
            return nil
        }
        return pageViewControllers[currentIndex - 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = pageViewControllers.firstIndex(of: viewController),
              currentIndex < pageViewControllers.count - 1 else {
            return nil
        }
        return pageViewControllers[currentIndex + 1]
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard completed,
              let visibleViewController = pageViewController.viewControllers?.first,
              let index = pageViewControllers.firstIndex(of: visibleViewController) else {
            return
        }
        
        currentPageIndex = index
        pageDelegate?.onboardingPageViewController(self, didUpdatePageIndex: index)
    }
}
