//
//  VideoPlayerVIewControllerTest.swift
//  graphyAppTests
//
//  Created by Balaji Sivaji on 02/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import XCTest
@testable import graphyApp

class VideoPlayerVIewControllerTest: XCTestCase {
    
    var videoVC: VideoPlayerViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.videoVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController
        self.videoVC.loadView()
        self.videoVC.viewDidLoad()
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
    
    func testPlayPauseButtonAction() {
        XCTAssertTrue(self.videoVC.responds(to: #selector(self.videoVC.playPauseButtonTap(sender:))))
    }
    
    func testMuteButtonAction() {
        XCTAssertTrue(self.videoVC.responds(to: #selector(self.videoVC.muteButtonTapped(sender:))))
    }
    
    func testTapRewindeButtonAction() {
        XCTAssertTrue(self.videoVC.responds(to: #selector(self.videoVC.onTapRewindButton(_:))))
    }
    
    func testTapForwardButtonAction() {
        XCTAssertTrue(self.videoVC.responds(to: #selector(self.videoVC.onTapForwardButton(_:))))
    }

}
