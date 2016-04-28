//
//  PageLogic.swift
//  Challenge
//
//  Created by ViViViViViVi on 2016/4/28.
//  Copyright © 2016年 Yue-Ting, HSIEH. All rights reserved.
//

import Foundation

enum PagingErrorType: ErrorType {
    case NoMoreBackPage(currentPage: Int)
    case NoMoreNextPage(maxPageCount: Int)
    
    var descripe: String {
        switch self {
        case .NoMoreBackPage(let currentPage):
            return "There is no more page to back. The currentPage is \(currentPage)."
        case .NoMoreNextPage(let maxPageCount):
            return "There is no more page to back. The maxPageCount is \(maxPageCount)."
        }
    }
}

class PageLogic: NSObject {
    
    var maxPageCount: Int, pagingCount: Int
    dynamic var currentPage: Int = 0
    
    init(maxPageCount: Int, pagingCount: Int, currentPage: Int) {
        self.maxPageCount = maxPageCount
        self.pagingCount = pagingCount
        self.currentPage = currentPage
        super.init()
    }
    
    convenience init(maxPageCount: Int) {
        self.init(maxPageCount: maxPageCount, pagingCount: 1, currentPage: 0)
    }
    
    func canNextPage() -> Bool {
        if currentPage + pagingCount <= maxPageCount {
            return true
        }
        return false
    }
    
    func canBackPage() -> Bool {
        if currentPage - pagingCount >= 0 {
            return true
        }
        return false
    }
    
    func nextPage() throws {
        if canNextPage() {
            currentPage += pagingCount
            return
        }
        throw PagingErrorType.NoMoreNextPage(maxPageCount: maxPageCount)
    }
    
    func backPage() throws {
        if canBackPage() {
            currentPage -= pagingCount
            return
        }
        throw PagingErrorType.NoMoreBackPage(currentPage: currentPage)
    }
}