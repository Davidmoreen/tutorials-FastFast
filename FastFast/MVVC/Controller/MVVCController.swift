import UIKit
import SwiftUI

class MVVCController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let cellId = "fastCell"

    @IBOutlet private weak var tableView: UITableView!

    private var viewModel: FastingViewModelProtocol

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: FastingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "MVVC"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewModel()
        configureTableView()
        configureHeaderView()
    }

    // MARK: - Bindings
    private func configureViewModel() {

    }

    // MARK: - View Setup
    private func configureTableView() {
        tableView.register(FastCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = EmptyStateView.makeView(title: "No Fasts Yet")
        tableView.tableFooterView?.frame = .init(x: 0, y: 0, width: 0, height: 150)
    }

    private func configureHeaderView() {
        let hostingController = UIHostingController(rootView: FastingTimer(
            fastEnded: { [weak self] fast in
                guard let self else { return }
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [.init(row: self.viewModel.fasts.count, section: 0)], with: .automatic)
                self.viewModel.createFast(fast)
                self.tableView.endUpdates()
            }
        ))
        tableView.tableHeaderView = hostingController.view
        tableView.tableHeaderView?.frame = .init(x: 0, y: 0, width: 0, height: 420)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableFooterView?.isHidden = viewModel.hasFasts
        return viewModel.fasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // Configure the cell...
        let fast = viewModel.fasts[indexPath.row]

        cell.textLabel?.text = fast.dateString
        cell.detailTextLabel?.text = fast.elapsedString

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fast = viewModel.fasts[indexPath.row]
            viewModel.deleteFast(fast)
            tableView.beginUpdates()
            tableView.deleteRows(at: [.init(row: indexPath.row, section: 0)], with: .automatic)
            tableView.endUpdates()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Fasting History"
    }

}
