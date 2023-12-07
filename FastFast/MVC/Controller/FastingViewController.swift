import UIKit
import SwiftUI

class FastingViewController: UIViewController {
    private let cellId = "fastCell"

    @IBOutlet private weak var tableView: UITableView!

    private var fasts: [Fast] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureHeaderView()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "MVC"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Setup
    func configureTableView() {
        tableView.register(FastCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = EmptyStateView.makeView(title: "No Fasts Yet")
        tableView.tableFooterView?.frame = .init(x: 0, y: 0, width: 0, height: 150)
    }

    func configureHeaderView() {
        let hostingController = UIHostingController(rootView: FastingTimer(
            fastEnded: self.fastEnded
        ))
        tableView.tableHeaderView = hostingController.view
        tableView.tableHeaderView?.frame = .init(x: 0, y: 0, width: 0, height: 420)
    }

    // MARK: - Fasts
    private func fastEnded(_ fast: Fast) {
        fasts.append(fast)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: fasts.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}

extension FastingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FastingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableFooterView?.isHidden = fasts.count > 0
        return fasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // Configure the cell...
        let fast = fasts[indexPath.row]

        cell.textLabel?.text = fast.dateString
        cell.detailTextLabel?.text = fast.elapsedString

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fasts.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [.init(row: indexPath.row, section: 0)], with: .automatic)
            tableView.endUpdates()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Fasting History"
    }
}
