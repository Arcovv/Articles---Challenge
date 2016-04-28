//
//  ArticlesViewController.swift
//  Challenge
//
//  Created by ViViViViViVi on 2016/4/26.
//  Copyright © 2016年 Yue-Ting, HSIEH. All rights reserved.
//

import UIKit


private let detailSegueIdentifier = "ShowDetail"
private let cellIdentifier        = "Cell"
private let articleCellIdentifier       = String(ArticleCell)

class ArticlesViewController: UITableViewController {
    
    // MARK: - Properties
    
    var articles: [Article]!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articles = Articles.single().articles
        
        
        tableView.registerNib(UINib(nibName: articleCellIdentifier, bundle: nil),
                              forCellReuseIdentifier: articleCellIdentifier)
        tableView.rowHeight = 88.0
    }
}

// MARK: - Navigation

extension ArticlesViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == detailSegueIdentifier,
            let detailVC = segue.destinationViewController as? DetailViewController,
            let cell = sender as? ArticleCell, let indexPath = tableView.indexPathForCell(cell) {
            
            detailVC.article = articles[indexPath.row]
        }
    }
}

// MARK: - UITableView Data Source

extension ArticlesViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(articleCellIdentifier, forIndexPath: indexPath) as! ArticleCell
        
        cellConfigurateTitle(cell, indexPath: indexPath)
        
        return cell
    }
}

extension ArticlesViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        performSegueWithIdentifier(detailSegueIdentifier, sender: cell)
    }
}

// MARK: - Cell Configuration

extension ArticlesViewController {
    
    func cellConfigurateTitle(articleCell: ArticleCell, indexPath: NSIndexPath) {
        let article = articles[indexPath.row]
        articleCell.titleLabel.text = article.title
        articleCell.authorLabel.text = article.author
    }
}