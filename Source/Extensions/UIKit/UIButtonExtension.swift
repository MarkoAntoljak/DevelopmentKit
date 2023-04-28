//
//  UIButtonExtension.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 27/04/2023.
//

import Foundation
import UIKit

public extension UIButton {
    /// Adds reactivity to a UIButton when user holds, press or releases the button.
    func addButtonReactivity() {
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
    }
}
