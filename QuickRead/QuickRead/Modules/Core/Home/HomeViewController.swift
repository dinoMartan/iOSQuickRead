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
        fetchSources {
            self.presentArticles()
        }
    }
    
    private func fetchSources(completion: @escaping (() -> Void)) {
        APIHandler.shared.getAllSources { sourcesResponse in
            Sources.shared.setSources(sources: sourcesResponse.sources)
            completion()
        } failure: { error in
            completion()
            // to do - handle error
        }
    }
    
    private func presentArticles() {
        guard let articlesViewController = UIStoryboard.init(name: "Articles", bundle: nil).instantiateViewController(identifier: "articles") as? ArticlesViewController else { return  }
        articlesViewController.setCategory(category: category)
        navigationController?.pushViewController(articlesViewController, animated: true)
    }

}
