//
//  Resolution.swift
//  OneMenu
//
//  Created by iMacRoman on 15.11.2023.
//

import Foundation
import AppKit

extension CGDirectDisplayID  {
    var displayMode: CGDisplayMode? { CGDisplayCopyDisplayMode(self) }
    func allDisplayModes(options: CFDictionary? = nil) -> [CGDisplayMode] { CGDisplayCopyAllDisplayModes(self, options) as? [CGDisplayMode] ?? [] }
}

extension CGDisplayMode {
    var resolution: String { .init(width) + " x " + .init(height) }
//    var height: String { .init(height)}
//    var width: String { .init(width)}
}


struct Display {
    static var main: CGDirectDisplayID { CGMainDisplayID() }
    static var mode: CGDisplayMode? { main.displayMode }
    static func allModes(for directDisplayID: CGDirectDisplayID = main) -> [CGDisplayMode] { directDisplayID.allDisplayModes() }
}
