import UIKit

class TabBar: UITabBar {

    var images = ["characterIcon", "tailBeastIcon", "akatsukiIcon"]

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTabBarItems()
    }
    
    private func setupTabBarItems() {
        // Ensure that there are tab bar items to work with
        guard let tabItems = self.items else { return }
        
        // Loop through each tab bar item and set its image
        for (index, item) in tabItems.enumerated() {
            if index < images.count {
                // Load image from the asset catalog
                if let image = UIImage(named: images[index]) {
                    // Resize image if needed
                    let resizedImage = image.withRenderingMode(.alwaysOriginal)
                    
                    // Set the image for the tab bar item
                    item.image = resizedImage
                    
                    // Optionally, you can adjust the image size using imageInsets
                    item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
                }
            }
        }
    }
}
