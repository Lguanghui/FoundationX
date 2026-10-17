//
//  FoldableDeviceInteraction.swift
//  FoundationX
//
//  Created by Guanghui Liang on 2026/10/17.
//

#if os(iOS)
import UIKit

/// Observes foldable-device capability in a view hierarchy, independent of bar orientation.
///
/// Add this interaction to a view. UIKit retains it for as long as it is attached.
/// `isFoldable` is initially false and changes when the system supplies hinge information.
/// A closed hinge still identifies a foldable device. Detaching the view preserves the last
/// known value; attaching to another window allows that window's capability to replace it.
///
/// This detects a capability, not the Duo product name. Future devices exposing the same
/// UIKit hinge API are supported without a model-name list. Hinge observation requires
/// building with the iOS 27.1 SDK and running iOS 27.1 or later; older toolchains and systems
/// retain the false fallback.
@MainActor
public final class FoldableDeviceInteraction: NSObject, UIInteraction {
    public private(set) weak var view: UIView?
    public private(set) var isFoldable = false

    private var hingeInteraction: (any UIInteraction)?
    private let onChange: @MainActor (Bool) -> Void

    /// Called when the detected capability changes. Capture view controllers weakly.
    public init(onChange: @escaping @MainActor (Bool) -> Void) {
        self.onChange = onChange
        super.init()
    }

    public func willMove(to view: UIView?) {
        let previousView = self.view
        self.view = nil
        if let hingeInteraction { previousView?.removeInteraction(hingeInteraction) }
        hingeInteraction = nil
    }

    public func didMove(to view: UIView?) {
        self.view = view
        guard let view else { return }
        // Swift 6.2 toolchains remain supported without referencing newer SDK declarations.
        #if compiler(>=6.4)
        if #available(iOS 27.1, *) {
            let interaction = UIHingeInteraction { [weak self] interaction, update in
                guard let self, hingeInteraction === interaction else { return }
                receiveHingeUpdate(hasHinge: update.hinge != nil)
            }
            hingeInteraction = interaction
            view.addInteraction(interaction)
        }
        #endif
    }

    func receiveHingeUpdate(hasHinge: Bool) {
        guard view?.window != nil, isFoldable != hasHinge else { return }
        isFoldable = hasHinge
        onChange(hasHinge)
    }
}
#endif
