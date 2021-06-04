//
//  FilterViewController.swift
//  CocktailDBTestApp
//
//  Created by Blezin on 01.06.2021.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    var selectedtheSame = false
    private var startSelectedRow: [IndexPath]?
    var categories = [Categories]()
    var selectedCategories: [IndexPath]? {
        tableView.indexPathsForSelectedRows
    }
override func viewWillAppear(_ animated: Bool) {
        for (index, value) in categories.enumerated() {
            if value.filtered {
                let indexPath = IndexPath(row: index, section: 0)
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
            }
        }
        startSelectedRow = tableView.indexPathsForSelectedRows
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        selectedtheSame = startSelectedRow?.sorted() == selectedCategories?.sorted()
        if categories.filter({$0.filtered}).isEmpty {
           selectedtheSame = startSelectedRow?.count == categories.count
            for i in categories {
                i.filtered = true
            }
        }
    }
}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        cell?.backgroundColor = .clear
        categories[indexPath.row].filtered = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
        categories[indexPath.row].filtered = false
    }
}
