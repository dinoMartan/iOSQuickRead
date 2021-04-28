//
//  OtherViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 25/04/2021.
//

import UIKit

class OtherViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private properties
    
    private var categories: [String] = []
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        configureTableView()
        fetchData()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchData() {
        APIHandler.shared.getAllCategories { categoriesResponse in
            self.categories = categoriesResponse.categories
            self.tableView.reloadData()
        } failure: { error in
            // to do - handle error
        }

    }

}

//MARK: - Public extensions -

extension OtherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherTableViewCell.identifier) as? OtherTableViewCell else { return UITableViewCell() }
        
        let category = categories[indexPath.row]
        let newValue = String.titleCase(category)()
        cell.configureCell(category: newValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let articlesViewController = UIStoryboard.init(name: "Articles", bundle: nil).instantiateViewController(identifier: "articles") as? ArticlesViewController else { return  }
        articlesViewController.setCategory(category: categories[indexPath.row])
        navigationController?.pushViewController(articlesViewController, animated: true)
    }
    
}
