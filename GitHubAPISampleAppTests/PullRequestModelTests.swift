//
//  PullRequestModelTests.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 19/01/25.
//

import Quick
import Nimble
@testable import GitHubAPISampleApp

final class PullRequestModelTests: QuickSpec {
    override class func spec() {
        describe("a PullRequest model") {
            var pullRequest: PullRequest?
            
            context("state is nil") {
                beforeEach {
                    pullRequest = PullRequest(htmlUrl: URL(filePath: ""), title: "",
                                              user: .init(id: 0, login: "", name: nil, avatarUrl: URL(string: "")),
                                              body: nil, createdAt: "", mergedAt: nil, state: nil, draft: true)
                }
                
                it("should return a completeState unowned") {
                    expect(pullRequest?.completeState).to(equal(.unowned))
                }
            }
            
            context("state is open and draft is true") {
                beforeEach {
                    pullRequest = PullRequest(htmlUrl: URL(filePath: ""), title: "",
                                              user: .init(id: 0, login: "", name: nil, avatarUrl: URL(string: "")),
                                              body: nil, createdAt: "", mergedAt: nil, state: "open", draft: true)
                }
                
                it("should return a completeState draft") {
                    expect(pullRequest?.completeState).to(equal(.draft))
                }
            }
            
            context("state is open and draft is false") {
                beforeEach {
                    pullRequest = PullRequest(htmlUrl: URL(filePath: ""), title: "",
                                              user: .init(id: 0, login: "", name: nil, avatarUrl: URL(string: "")),
                                              body: nil, createdAt: "", mergedAt: nil, state: "open", draft: false)
                }
                
                it("should return a completeState open") {
                    expect(pullRequest?.completeState).to(equal(.open))
                }
            }
            
            context("state is closed and merged is nil") {
                beforeEach {
                    pullRequest = PullRequest(htmlUrl: URL(filePath: ""), title: "",
                                              user: .init(id: 0, login: "", name: nil, avatarUrl: URL(string: "")),
                                              body: nil, createdAt: "", mergedAt: nil, state: "closed", draft: true)
                }
                
                it("should return a completeState closed") {
                    expect(pullRequest?.completeState).to(equal(.closed))
                }
            }
            
            context("state is open and merged is not nil") {
                beforeEach {
                    pullRequest = PullRequest(htmlUrl: URL(filePath: ""), title: "",
                                              user: .init(id: 0, login: "", name: nil, avatarUrl: URL(string: "")),
                                              body: nil, createdAt: "", mergedAt: "", state: "closed", draft: false)
                }
                
                it("should return a completeState merged") {
                    expect(pullRequest?.completeState).to(equal(.merged))
                }
            }
        }
    }
}
