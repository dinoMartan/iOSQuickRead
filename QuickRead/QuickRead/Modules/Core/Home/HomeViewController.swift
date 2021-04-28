//
//  HomeViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 24/04/2021.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let category = "vijesti"
    private var articles: [Article] = []
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        fetchData()
        presentArticles()
    }
    
    private func fetchData() {
        fetchSources()
    }
    
    private func fetchSources() {
        APIHandler.shared.getAllSources { sourcesResponse in
            Sources.shared.setSources(sources: sourcesResponse.sources)
        } failure: { error in
            // to do - handle error
        }
    }
    
    private func presentArticles() {
        guard let articlesViewController = UIStoryboard.init(name: "Articles", bundle: nil).instantiateViewController(identifier: "articles") as? ArticlesViewController else { return  }
        articlesViewController.setCategory(category: category)
        navigationController?.pushViewController(articlesViewController, animated: true)
    }

}
