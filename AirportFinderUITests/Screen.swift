//
//  Screen.swift
//  AirportFinderUITests
//
//  Created by mac on 10/4/19.
//

import XCTest

extension XCUICoordinate {
    
    static let half: CGFloat = 0.5
    static let pressDuration: TimeInterval = 0.01
    static let lessThanHalf = half - 0.25
    static let moreThanHalf = half + 0.25
    
    fileprivate func scroll(_ direction: UIAccessibilityScrollDirection, in element: XCUIElement) {
        let toVector: CGVector
        
        switch direction {
        case .up:
            toVector = CGVector(dx: XCUICoordinate.half, dy: XCUICoordinate.lessThanHalf)
        case .down:
            toVector = CGVector(dx: XCUICoordinate.half, dy: XCUICoordinate.moreThanHalf)
        case .left:
            toVector = CGVector(dx: XCUICoordinate.lessThanHalf, dy: XCUICoordinate.half)
        case .right:
            toVector = CGVector(dx: XCUICoordinate.moreThanHalf, dy: XCUICoordinate.half)
        default:
            toVector = .zero
        }
        
        let dragTo = element.coordinate(withNormalizedOffset: toVector)
        press(forDuration: XCUICoordinate.pressDuration, thenDragTo: dragTo)
    }
}

extension XCUIElement {
    
    func visible() -> Bool {
        guard exists && !frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
    }
    
    func scrollTo(element: XCUIElement,
                  _ direction: UIAccessibilityScrollDirection = .up,
                  _ maxScrolls: Int = 5) {
        (0...maxScrolls).forEach { _ in
            if !element.visible() || !element.isHittable {
                scroll(direction)
            }
        }
    }
    
    private func scroll(_ direction: UIAccessibilityScrollDirection) {
        let centre = coordinate(withNormalizedOffset: CGVector(dx: XCUICoordinate.half, dy: XCUICoordinate.half))
        centre.scroll(direction, in: self)
    }
}

class Screen {
    
    internal var app: XCUIApplication
    
    required init(_ app: XCUIApplication) {
        self.app = app
    }
    
    func on<T: Screen>(screen: T.Type) -> T {
        let nextScreen: T
        
        if self is T,
            let nextScreen = self as? T {
            return nextScreen
        }
        
        nextScreen = screen.init(app)
        return nextScreen
    }
}
