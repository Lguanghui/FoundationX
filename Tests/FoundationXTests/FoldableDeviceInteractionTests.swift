// Created by Guanghui Liang on 2026/10/17.

#if os(iOS)
import UIKit
import XCTest
@testable import FoundationX

@MainActor
final class FoldableDeviceInteractionTests: XCTestCase {
    func testCapabilityChangesAreDeduplicatedAndDetachedUpdatesAreIgnored() {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 400, height: 800))
        let view = UIView()
        window.addSubview(view)
        var changes: [Bool] = []
        let interaction = FoldableDeviceInteraction { changes.append($0) }
        view.addInteraction(interaction)

        XCTAssertFalse(interaction.isFoldable)
        interaction.receiveHingeUpdate(hasHinge: true)
        interaction.receiveHingeUpdate(hasHinge: true)
        XCTAssertTrue(interaction.isFoldable)
        XCTAssertEqual(changes, [true])

        view.removeFromSuperview()
        interaction.receiveHingeUpdate(hasHinge: false)
        XCTAssertTrue(interaction.isFoldable)
        XCTAssertEqual(changes, [true])

        window.addSubview(view)
        interaction.receiveHingeUpdate(hasHinge: false)
        XCTAssertFalse(interaction.isFoldable)
        XCTAssertEqual(changes, [true, false])
    }

    func testRemovingAndReattachingInteractionCleansUpHingeObservation() {
        let first = UIView()
        let second = UIView()
        let interaction = FoldableDeviceInteraction { _ in }
        first.addInteraction(interaction)
        XCTAssertTrue(interaction.view === first)
        first.removeInteraction(interaction)
        XCTAssertNil(interaction.view)
        XCTAssertTrue(first.interactions.isEmpty)

        second.addInteraction(interaction)
        XCTAssertTrue(interaction.view === second)
        second.removeInteraction(interaction)
        XCTAssertTrue(second.interactions.isEmpty)
    }
}
#endif
