//
//  HomeViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 24/04/2021.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private properties
    
    private var articles: [Article] = []
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        fetchData()
        configureTableView()
    }
    
    private func fetchData() {
        APIHandler.shared.getAllArticles { getAllArticlesResponse in
            self.articles = getAllArticlesResponse.articles
            self.tableView.reloadData()
        } failure: { error in
            // to do - handle error
        }

    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier) as? ArticleTableViewCell else { return UITableViewCell() }
        cell.configureCell(article: articles[indexPath.row])
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
}



extension HomeViewController: ArticleTableViewCellDelegate {
    
    func didTapShowArticle(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
}


