//
//  ArticleTableViewCell.swift
//  QuickRead
//
//  Created by Dino Martan on 25/04/2021.
//

import UIKit
import SDWebImage

protocol ArticleTableViewCellDelegate: AnyObject {
    
    func didTapShowArticle(url: URL)
    
}

class ArticleTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    @IBOutlet weak var articlePublishDateLabel: UILabel!
    @IBOutlet weak var articleTextView: UITextView!
    @IBOutlet weak var articleSourceLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "articleCell"
    weak var delegate: ArticleTableViewCellDelegate?
    
    //MARK: - Private properties
    
    private var article: Article?
    
    func configureCell(article: Article) {
        self.article = article
        articleImageView.sd_setImage(with: URL(string: article.imageURL), completed: nil)
        articleTitleLabel.text = article.title
        articleAuthorLabel.text = article.author
        articlePublishDateLabel.text = article.publishDate
        articleTextView.text = article.summary
        articleSourceLabel.text = article.idSource.replacingOccurrences(of: "https://www.", with: "")
        updateTextFont(textView: articleTextView)
    }
    
}

//MARK: - Private extensions -

extension ArticleTableViewCell {
    
    // StackOverflow: https://stackoverflow.com/questions/2038975/resize-font-size-to-fill-uitextview
    private func updateTextFont(textView: UITextView) {
        if (textView.text.isEmpty || textView.bounds.size.equalTo(CGSize.zero)) {
            return;
        }

        let textViewSize = textView.frame.size;
        let fixedWidth = textViewSize.width;
        let expectSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))

        var expectFont = textView.font;
        if (expectSize.height > textViewSize.height) {
            while (textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height > textViewSize.height) {
                expectFont = textView.font!.withSize(textView.font!.pointSize - 1)
                textView.font = expectFont
            }
        }
        else {
            while (textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height < textViewSize.height) {
                expectFont = textView.font;
                textView.font = textView.font!.withSize(textView.font!.pointSize + 1)
            }
            textView.font = expectFont;
        }
    }
    
}

//MARK: - IBActions -

extension ArticleTableViewCell {
    
    @IBAction func didTapShowArticleButton(_ sender: Any) {
        guard let urlString = article?.idURL, let articleUrl = URL(string: urlString) else { return }
        delegate?.didTapShowArticle(url: articleUrl)
    }
    
}
