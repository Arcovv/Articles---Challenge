/**
 * Copyright (c) 2016 YueJun_HSIEH
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import UIKit


private let detailSegueIdentifier = "ShowDetail"
private let cellIdentifier        = "Cell"
private let articleCellIdentifier = String(ArticleCell)

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