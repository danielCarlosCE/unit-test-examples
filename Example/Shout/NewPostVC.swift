import UIKit


class NewPostVC: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var apiClient: ApiClient!
    var rows: [UITableViewCell] = []
    var icons: [Icon] = []

    var environment: Environment!

    //MARK: Incoming Command
    override func viewDidLoad() {
        setupTableView()
        registerObservers()
    }

    override func viewWillAppear(_ animated: Bool) {
        //MARK: Outgoing query
        apiClient.fetchIcons { result in
            switch result {
            case .success(let icons):
                self.icons = icons
            default: break
            }
        }
    }

    //MARK: Incoming Query
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return rows[indexPath.row]
    }

    //MARK: Outgoing commands
    func registerObservers() {
        environment.notificationCenter.addObserver(self, selector: Selector(("keyboardWillShow:")),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        environment.notificationCenter.addObserver(self, selector: Selector(("keyboardWillHide:")),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }


    //MARK: Private
    private func setupTableView() {
        let projectUserSelectionCell = tableViewCell("ProjectUserSelectionCellIdentifier")
        let textViewCell             = tableViewCell("SelfSizingTextViewCellIdentifier")
        let datePickerCell           = tableViewCell("ExpandingDatePickerCellIdentifier")
        rows = [projectUserSelectionCell, textViewCell, datePickerCell]
    }

    private func tableViewCell<T>(_ identifier: String) -> T where T: UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: identifier) as! T
    }

}

//MARK: Embracing Globals
struct Environment {
    let notificationCenter: NotificationCenterProtocol
}

protocol NotificationCenterProtocol {
    func addObserver(_ observer: Any, selector aSelector: Selector,
                     name aName: NSNotification.Name?, object anObject: Any?)
}

extension NotificationCenter: NotificationCenterProtocol {}



//MARK: Other types
class Icon {
    @NSManaged var title: String
}

protocol ApiClient {
    func fetchIcons(completion: @escaping (Result<[Icon]>) -> Void)
}

class ParseClient: ApiClient{
    func fetchIcons(completion: @escaping (Result<[Icon]>) -> Void) {

    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

class ProjectUserSelectionCell: UITableViewCell {

}
