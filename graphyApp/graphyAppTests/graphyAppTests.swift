//
//  graphyAppTests.swift
//  graphyAppTests
//
//  Created by Sudhakar on 02/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import XCTest
@testable import graphyApp

class graphyAppTests: XCTestCase {

    var homeVC: HomeViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.homeVC =  UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        self.homeVC.loadView()
        self.homeVC.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testHasATableView() {
        XCTAssertNotNil(self.homeVC.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(self.homeVC.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(self.homeVC.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(self.homeVC.responds(to: #selector(self.homeVC.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(self.homeVC.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(self.homeVC.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(self.homeVC.responds(to: #selector(self.homeVC.numberOfSections(in:))))
        XCTAssertTrue(self.homeVC.responds(to: #selector(self.homeVC.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(self.homeVC.responds(to: #selector(self.homeVC.tableView(_:cellForRowAt:))))
    }

}
