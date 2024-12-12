import UIKit

class TabBarVc: UITabBarController, UITabBarControllerDelegate {
    
    @IBOutlet weak var iconTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarIcons()
        self.delegate = self // Set the delegate
    }
    
    private func setupTabBarIcons() {
        let iconNames = ["characterIcon", "tailBeastIcon", "akatsukiIcon"]
        
        // Ensure tabBarItems exist
        guard let tabBarItems = tabBar.items, tabBarItems.count == iconNames.count else {
            print("Mismatch between tab bar items and icons")
            return
        }
        
        for (index, item) in tabBarItems.enumerated() {
            if let image = UIImage(named: iconNames[index]) {
                let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 50, height: 50))
                item.image = resizedImage.withRenderingMode(.alwaysOriginal)
                item.selectedImage = resizedImage.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    // Tab bar item selection animation
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let viewControllers = viewControllers, let index = viewControllers.firstIndex(of: viewController) else {
            return
        }
        
        // Get the tab bar button view
        let tabBarButton = tabBar.subviews[index + 1]
        
        // Add animation to the tab bar button
        UIView.animate(withDuration: 0.3,
                       animations: {
                           tabBarButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                       }, completion: { _ in
                           UIView.animate(withDuration: 0.2) {
                               tabBarButton.transform = CGAffineTransform.identity
                           }
                       })
    }
}
