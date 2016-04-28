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

import Foundation

class Articles {
    
    // MARK: - Private Properties
    
    private static let suffix = "Article"
    
    class func single() -> Articles {
        return Articles()
    }
    
    private init() { }
    
    // MARK: - Propertie
    
    let articles = [
        Article(prefix: "First", title: "先做有价值的产品，再来谈变现", author: "造作 CEO 舒为"),
        Article(prefix: "Second", title: "How to Strategically Procrastinate and Actually Boost Your Creativity", author: "Edmond Lau"),
        Article(prefix: "Third", title: "How to Get Your App Featured on the App Store", author: "Rustam Tagiev")
    ]
    
    func getPath(article: Article) -> String {
        return parsePath(article)
    }
    
    func getAllPaths(articles: [Article]) -> [String] {
        return articles.map() { parsePath($0) }
    }
}

// MARK: - Private Function

extension Articles {
    
    private func parsePath(article: Article) -> String {
        return NSBundle.mainBundle().pathForResource(article.prefix + Articles.suffix, ofType: "html")!
    }
}