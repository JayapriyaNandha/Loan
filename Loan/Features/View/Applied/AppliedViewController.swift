/*
 Display a saved form list with details like name, loan amount, and date submitted.
 ○ Feel free to design the UI to display the application list as you see fit.
 */

import UIKit

class AppliedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel : LoanViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ScreenName.applied.rawValue
        tableView.dataSource = self
        tableView.delegate = self
        viewModel?.loadForms()
        viewModel?.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
}
extension AppliedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.forms.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as? AppliedLoanTableViewCell else { return UITableViewCell() }
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AppliedLoanTableViewCell
        cell.delegate = self
        if let form = viewModel?.forms[indexPath.row] {
            cell.setUp(form: form)
        }
        return cell
    }
}

extension AppliedViewController: deleteLoanProtocol {
    func delete(id: UUID?) {
        viewModel?.deleteForm(id: id)
    }
}
