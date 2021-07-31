//
//  ArticlesViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 27/04/2021.
//

import UIKit
import SafariServices

struct SourceModel {
    
    let id: String
    
    func getName() -> String {
        if id == "" { return "All Sources" }
        return id.replacingOccurrences(of: "https://www.", with: "")
    }
    
}

class ArticlesViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!

    @IBOutlet private weak var activityIndicatorView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet private weak var sourcePickerView: UIPickerView!
    
    //MARK: - Private properties
    
    private var refreshControl = UIRefreshControl()
    
    private var sourcesList: [SourceModel] = []
    private var selectedSource = ""
    
    private var category: String?
    
    private var articles: [Article] = []
    private var currentPage: Int = 1
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setCategory(category: String) {
        self.category = category
    }
    
    private func setupView() {
        showActivityIndicator()
        prepareSources()
        setTitle()
        fetchArticles()
        configureTableView()
    }

}

//MARK: - Private extensions -

//MARK: - Data handling

private extension ArticlesViewController {
    
    private func fetchArticles() {
        showActivityIndicator()
        if selectedSource == "" {
            guard let category = category else { return }
            APIHandler.shared.getArticlesForCategory(page: currentPage, category: category) { articlesResponse  in
                self.articles.append(contentsOf: articlesResponse.articles)
                self.tableView.reloadData()
                self.hideActivityIndicator()
            } failure: { error in
                //Alerter.showOneButtonAlert(on: self, title: .error, error: error, actionTitle: .ok, handler: nil)
            }
        }
        
        else {
            guard let category = category else { return }
            APIHandler.shared.getArticlesForSourceCategory(page: currentPage, source: selectedSource, category: category) { articlesResponse  in
                self.articles.append(contentsOf: articlesResponse.articles)
                self.tableView.reloadData()
                self.hideActivityIndicator()
            } failure: { error in
                // to do - handle error
            }
        }
    }
    
}

//MARK: - General setup

private extension ArticlesViewController {
    
    private func prepareSources() {
        sourcePickerView.delegate = self
        sourcePickerView.dataSource = self
        
        sourcesList.append(SourceModel(id: ""))
        for source in Sources.shared.getSources() {
            let sourceModel = SourceModel(id: source)
            sourcesList.append(sourceModel)
        }
    }
    
    private func setTitle() {
        guard let title = category else { return }
        self.title = String.titleCase(title)()
    }
    
}

//MARK: - ActivityIndicator setup

private extension ArticlesViewController {
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.5) {
            self.activityIndicatorView.alpha = 0
        }
        refreshControl.endRefreshing()
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicatorView.alpha = 1
    }
    
}

//MARK: - TableView setup

private extension ArticlesViewController {
    
    private func prepareRefreshing() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        currentPage = 1
        articles.removeAll()
        fetchArticles()
    }

    private func configureTableView() {
        prepareRefreshing()
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}


//MARK: - Delegates and DataSources -

//MARK: - TableView Delegate, DataSource

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        if index == articles.count - 1, currentPage < 100 {
            currentPage+=1
            fetchArticles()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier) as? ArticleTableViewCell else { return UITableViewCell() }
        cell.configureCell(article: articles[indexPath.row])
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
    
}

//MARK: - ArticleTableViewController Delegate

extension ArticlesViewController: ArticleTableViewCellDelegate {
    
    func didTapShowArticle(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.view.backgroundColor = .systemBackground
        present(safariViewController, animated: true, completion: nil)
    }
    
}

//MARK: - Picker Delegate and DataSource

extension ArticlesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sourcesList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sourcesList[row].getName()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSource = sourcesList[row].id
        articles.removeAll()
        currentPage = 1
        fetchArticles()
    }
    
}
