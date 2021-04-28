//
//  ArticlesViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 27/04/2021.
//

import UIKit
import SafariServices

class ArticlesViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private properties
    
    private var category: String?
    private var articles: [Article] = []
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setCategory(category: String) {
        self.category = category
    }
    
    private func setupView() {
        setTitle()
        fetchArticles()
        configureTableView()
    }
    
    private func setTitle() {
        guard let title = category else { return }
        self.title = title
    }
    
    private func fetchArticles() {
        guard let category = category else { return }
        APIHandler.shared.getArticlesForCategory(category: category) { getArticlesResponse in
            self.articles = getArticlesResponse.articles
            self.tableView.reloadData()
        } failure: { error in
            // to do - handle error
        }


    }

    private func configureTableView() {
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - TableView Delegate, DataSource -

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
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

extension ArticlesViewController: ArticleTableViewCellDelegate {
    
    func didTapShowArticle(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
}
