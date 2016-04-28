//
//  Articles.swift
//  Challenge
//
//  Created by ViViViViViVi on 2016/4/26.
//  Copyright © 2016年 Yue-Ting, HSIEH. All rights reserved.
//

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