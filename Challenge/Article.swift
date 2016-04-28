//
//  Article.swift
//  Challenge
//
//  Created by ViViViViViVi on 2016/4/26.
//  Copyright © 2016年 Yue-Ting, HSIEH. All rights reserved.
//

import Foundation

struct Article {
    
    let prefix: String
    let title: String
    let author: String
    
    init(prefix: String, title: String, author: String) {
        self.prefix = prefix
        self.title = title
        self.author = author
    }
}