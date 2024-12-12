import UIKit

class TabBarView: UITabBar {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTabBarIcons()
    }
    
    private func setupTabBarIcons() {
        
        let iconImages = ["characterIcon", "akatsukiIcon", "tailBeastIcon"]
        
        // Ensure the tab bar items match the icons
        guard let items = self.items, items.count == iconImages.count else {
            print("Tab bar items and icon images count do not match!")
            return
        }
        
        for (index, item) in items.enumerated() {
            item.image = UIImage(named: iconImages[index])?.withRenderingMode(.alwaysOriginal)
            
        }
    }
}
