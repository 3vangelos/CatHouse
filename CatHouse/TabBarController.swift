import UIKit

class TabBarController: UITabBarController {
    
    enum screen: Int {
        case recent = 0
        case favorites
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recentCatsViewController = CatsCollectionViewController()
        recentCatsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: screen.recent.rawValue)
        
        
        let likedCatsViewController = CatsCollectionViewController()
        likedCatsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: screen.favorites.rawValue)
        
        viewControllers = [ recentCatsViewController, likedCatsViewController  ]
    }
}
