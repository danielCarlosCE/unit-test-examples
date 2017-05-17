import XCTest
@testable import Example

class CategorySpecs: XCTestCase {

    //MARK: Incoming Commands
    func testInitWithValidJsonSetsProperties() {
        let json:[String : Any] = ["id": 123, "name": "sport"]

        let category = Category(json: json)

        XCTAssert(category?.id  == 123)
        XCTAssert(category?.name == "sport")

    }

}
