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

typealias HandlePage = (Int) -> ()

class PageLogic: NSObject {
    
    var maxPageCount: Int, pagingCount: Int
    dynamic var currentPage: Int = 0
    
    var userShowPage: Int {
        return currentPage + 1
    }
    
    var userShowMaxPageCount: Int {
        return maxPageCount + 1
    }
    
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
    
    func nextPage(handle: HandlePage?) {
        if canNextPage() {
            currentPage += pagingCount
            handle?(currentPage)
        } else {
            handle?(maxPageCount)
        }
    }
    
    func backPage(handle: HandlePage?) {
        if canBackPage() {
            currentPage -= pagingCount
            handle?(currentPage)
        } else {
            handle?(0)
        }
    }
}