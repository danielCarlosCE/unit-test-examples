import XCTest
@testable import Example

class DevicesCoordinatorSpecs: XCTestCase {

    //MARK: Outgoing Commands
    func testShowDetailsPushesDetailVCToNavigator() {
        let navigatorSpy = NavigatorSpy()
        let sut = DevicesCoordinator(navigator: navigatorSpy)

        sut.showDetails(of: PeripheralViewModel())

        XCTAssert(navigatorSpy.viewControllerPushed is DetailsVC)
        XCTAssertNotNil((navigatorSpy.viewControllerPushed as? DetailsVC)?.viewModel)
    }
}

class NavigatorSpy: Navigator {
    var viewControllerPushed: UIViewController?

    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewControllerPushed = viewController
    }

}
