//
//  Functions.swift
//  AutoBooks
//
//  Created by Evan Plant on 20/03/2026.
//

import Foundation
import UIKit

// MARK: - Extensions

// Source - https://stackoverflow.com/a/79534287
// Posted by itwend
// Retrieved 2026-03-20, License - CC BY-SA 4.0
extension Bundle {
    public var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }
}

