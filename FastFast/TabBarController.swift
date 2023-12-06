import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        configureTabs()
    }

    func configureTabs() {
        let viewControllers = [
            UINavigationController(rootViewController: MVCController()),
            UINavigationController(rootViewController: MVVCController(viewModel: FastingViewModel()))
        ]
        self.viewControllers = viewControllers
    }
}

