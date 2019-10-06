//
//  XCTestCaseExtension.swift
//  AirportFinderUITests
//
//  Created by mac on 10/4/19.
//

import XCTest

extension XCTestCase {
    
    func takeScreenshotOf(description: String? = nil, file: String = #file, testCase: String) {
        
        guard let fileUrl = URL(string: file) else { return }
        
        let projectPath = fileUrl
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let filename = screenshotFilename(description: description,
                                          fileUrl: fileUrl,
                                          testCase: testCase)
        let screenshot = XCUIScreen.main.screenshot()
        let saveUrl = projectPath
            .appendingPathComponent("Logs")
            .appendingPathComponent("failedTestScreenshots")
            .appendingPathComponent(filename)
        let fileURLWithPath = URL(fileURLWithPath: saveUrl.path)
        
        do {
            try FileManager.default.createDirectory(at: fileURLWithPath.deletingLastPathComponent(),
                                                    withIntermediateDirectories: true)
            try screenshot.pngRepresentation.write(to: fileURLWithPath)
        } catch {
            print("Screenshot was not saved")
        }
    }
    
    private func screenshotFilename(description: String?, fileUrl: URL, testCase: String) -> String {
        
        var result = testCase
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "-", with: "")
        
        result += ".png"
        return result
    }
}
