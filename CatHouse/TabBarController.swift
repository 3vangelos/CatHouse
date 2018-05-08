import UIKit

class TabBarController: UITabBarController {
    
    enum screen: Int {
        case recent = 0
        case favorites
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recentCatsViewController = CatsViewController(.recent)
        recentCatsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: screen.recent.rawValue)
        
        
        let likedCatsViewController = CatsViewController(.favorites)
        likedCatsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: screen.favorites.rawValue)
        
        viewControllers = [ recentCatsViewController, likedCatsViewController  ]
    }
}
