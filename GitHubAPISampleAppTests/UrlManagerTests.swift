//
//  UrlManagerTests.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 19/01/25.
//

import Quick
import Nimble
@testable import GitHubAPISampleApp

final class UrlManagerTests: QuickSpec {
    
    override class func spec() {
        describe("a UrlManager") {
            var createdUrl: String?
            
            context("get baseUrl") {
                it("should return GitHub API url") {
                    expect(UrlManager.baseUrl).to(equal("https://api.github.com/"))
                }
            }
            
            context("url string creation") {
                beforeEach {
                    createdUrl = UrlManager.createUrl("XPTO")
                }
                
                it("should return a url") {
                    expect(createdUrl).to(equal("https://api.github.com/XPTO"))
                }
            }
            
            context("url string with itensPerPage creation") {
                beforeEach {
                    createdUrl = UrlManager.createUrl("XXX", itensPerPage: 10)
                }
                
                it("should return a url with itensPerPage") {
                    expect(createdUrl).to(equal("https://api.github.com/XXX&per_page=10"))
                }
            }
            
            context("url string with currentPage creation") {
                beforeEach {
                    createdUrl = UrlManager.createUrl("XYZ", currentPage: 2)
                }
                
                it("should return a url with itensPerPage") {
                    expect(createdUrl).to(equal("https://api.github.com/XYZ&page=2"))
                }
            }
            
            context("url string with itensPerPage and currentPage creation") {
                beforeEach {
                    createdUrl = UrlManager.createUrl("ZZZ", itensPerPage: 15, currentPage: 3)
                }
                
                it("should return a url with itensPerPage and currentPage") {
                    expect(createdUrl).to(equal("https://api.github.com/ZZZ&per_page=15&page=3"))
                }
            }
        }
    }
}
