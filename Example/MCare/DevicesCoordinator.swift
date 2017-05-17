import UIKit

class DevicesCoordinator {

    var navigator: Navigator

    init(navigator: Navigator) {
        self.navigator = navigator
    }

    func showDetails(of peripheral: PeripheralViewModel) {
        let detailsVC = DetailsVC()
        detailsVC.viewModel = peripheral
        navigator.pushViewController(detailsVC, animated: true)
    }
}


protocol Navigator {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}
extension UINavigationController: Navigator { }


//MARK: Other types
struct PeripheralViewModel {}

class DetailsVC: UIViewController {
    var viewModel: PeripheralViewModel!
}
