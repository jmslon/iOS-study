import UIKit

class TableViewController: UIViewController {
    
    var data: [String] = ["A", "BB", "CCC", "DDDD"]
    
    private let TABLEVIEW_CELL_ID = "myCell"
    private let LEADING_ANCHOR_CONSTANT = 15.0
    private let TRAILING_ANCHOR_CONSTANT = 20.0
    private let TAB_BAR_HEIGHT = 10.0
    private let SEARCH_BAR_HEIGHT = 0.0
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftBarButtonItem = UIBarButtonItem(title: "Edit", image: nil, target: self, action: #selector(setEditing))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        self.navigationItem.title = "Title here"
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LEADING_ANCHOR_CONSTANT).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -TRAILING_ANCHOR_CONSTANT).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: SEARCH_BAR_HEIGHT).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -TAB_BAR_HEIGHT).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TABLEVIEW_CELL_ID)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc override func setEditing(_ editing: Bool, animated: Bool) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            navigationItem.leftBarButtonItem?.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            navigationItem.leftBarButtonItem?.title = "Done"
        }
    }

    @objc func addAction() {
        tableView.beginUpdates()
        self.data.append("a new row!")
        tableView.insertRows(at: [IndexPath(row: data.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }

}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TABLEVIEW_CELL_ID, for: indexPath)
        cell.textLabel?.text = self.data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let cell = self.data[sourceIndexPath.row]
        self.data.remove(at: sourceIndexPath.row)
        self.data.insert(cell, at: destinationIndexPath.row)
    }
    
}
