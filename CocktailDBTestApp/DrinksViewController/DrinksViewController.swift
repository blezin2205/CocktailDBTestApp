//
//  ViewController.swift
//  CocktailDBTestApp
//
//  Created by Blezin on 01.06.2021.
//

import UIKit

class DrinksViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    private var indexSection = 0
    private var drinksArrayForCategory = [DrinksForCategory]()
    var categories = [Categories]()
    private lazy var footerView = FooterView()
    private var selectedTheSame = false
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.tableFooterView = footerView
        filterButton.isEnabled = false
        tableView.register(DrinkViewCell.self, forCellReuseIdentifier: DrinkViewCell.reuseId)
        startFetch()
    }

    private func startFetch() {
        networkManager.startFetch(categories: categories, sectionIndex: indexSection) { [unowned self] result in
            switch result {
            case .success(let result):
                categories = result.categories
                drinksArrayForCategory.append(result.drinkForCategory)
                DispatchQueue.main.async {
                    tableView.reloadData()
                    filterButton.isEnabled = true
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    footerView.setTitle("Data can't be downloaded")
                    showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "filter" else { return }
        guard let destination = segue.destination as? FilterViewController else {return }
        destination.categories = categories
    }
    
    @IBAction func applyButton(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "filter" else {return}
        guard let source = unwindSegue.source as? FilterViewController else { return }
        selectedTheSame = source.selectedtheSame
        categories = source.categories
        if !selectedTheSame {
        print("Not th same")
                    footerView.setTitle(nil)
                    indexSection = 0
                    drinksArrayForCategory.removeAll()
                    startFetch()
                }
    }
}

extension DrinksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return drinksArrayForCategory.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let nameSection = drinksArrayForCategory[section].categoryName
        return nameSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksArrayForCategory[section].drinksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinkViewCell.reuseId, for: indexPath) as! DrinkViewCell
        let drinkData = drinksArrayForCategory[indexPath.section].drinksArray[indexPath.row]
        cell.setCell(data: drinkData)
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                let sectionsCount = categories.filter({$0.filtered}).count
                if sectionsCount - 1 > indexSection {
                    footerView.setTitle(nil)
                    footerView.showLoader()
                    indexSection += 1
                    startFetch()
                    
                } else {
                    let totalDrinkCount = drinksArrayForCategory.flatMap({$0.drinksArray}).count
                    footerView.setTitle("Loaded all content \n (\(sectionsCount) sections and \(totalDrinkCount) drinks)")
                }
            }
        }
    }
}



