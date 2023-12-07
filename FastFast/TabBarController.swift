import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureTabs()
    }

    func configureTabs() {
        let viewControllers = [
            UINavigationController(rootViewController: FastingViewController()),
            UINavigationController(rootViewController: FastingMVVMViewController(viewModel: FastingViewModel()))
        ]
        self.viewControllers = viewControllers
    }
}

