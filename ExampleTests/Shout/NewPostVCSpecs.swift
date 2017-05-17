import XCTest
@testable import Example

class NewPostVCSpecs: XCTestCase {

    var sut: NewPostVC!
    var apiClientStub: SuccessApiClientStub!
    var testEnvironment: Environment!

    override func setUp() {
        apiClientStub = SuccessApiClientStub()

        let notificationCenterSpy = NotificationCenterSpy()
        testEnvironment = Environment(notificationCenter: notificationCenterSpy)

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyBoard.instantiateViewController(withIdentifier: "NewPostVC") as! NewPostVC
        sut.apiClient = apiClientStub
        sut.environment = testEnvironment
        _ = sut.view
    }

    //MARK: Incoming Commands
    //Assert direct public side effects
    func testOutletsAreSetAfterLoadingView() {
        XCTAssertNotNil(sut.tableView)
    }

    func testRowsAreNotEmptyAfterViewDidLoad() {
        sut.viewDidLoad()
        XCTAssert(sut.rows.count > 0)
    }

    //MARK: Incoming Queries
    func testNumberOfRowsForFirstSectionReturnsThree() {
        sut.viewDidLoad()

        let actual = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        let expected = 3

        XCTAssertEqual(actual, expected)
    }

    func testCellForFirstIndexReturnsProjectUserSelectionCell() {
        sut.viewDidLoad()
        let index = IndexPath(row: 0, section: 0)

        let firstCell = sut.tableView(sut.tableView, cellForRowAt: index)

        XCTAssert(firstCell is ProjectUserSelectionCell)
    }

    //MARK: Outgoing Commands
    func testViewDidLoadAddsObserverToNotificationCenter() {
        let notificationCenterSpy = sut.environment.notificationCenter as! NotificationCenterSpy

        sut.viewDidLoad()

        XCTAssert(notificationCenterSpy.didCallAddObserver)
    }
}

class SuccessApiClientStub: ApiClient {
    func fetchIcons(completion: @escaping (Result<[Icon]>) -> Void) {
        completion(.success([Icon()]))
    }
}

class NotificationCenterSpy: NotificationCenterProtocol {
    var didCallAddObserver = false
    func addObserver(_ observer: Any, selector aSelector: Selector,
                     name aName: NSNotification.Name?, object anObject: Any?) {
        didCallAddObserver = true

    }
}


