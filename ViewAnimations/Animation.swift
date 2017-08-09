//
//  Animation.swift
//  ViewAnimations
//
//  Created by Alex da Franca on 09.08.17.
//  Copyright © 2017 Farbflash. All rights reserved.
//

import UIKit

/// The model for the animation
public struct Animation {
    public let duration: TimeInterval
    public let closure: (UIView) -> Void
    public let damping: Double? = nil
}

public extension Animation {
    static func fadeIn(duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, closure: { $0.alpha = 1 })
    }

    static func resize(to size: CGSize, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, closure: { $0.bounds.size = size })
    }

    static func move(byX x: CGFloat, y: CGFloat, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, closure: { $0.center = $0.center.applying(CGAffineTransform(translationX: x, y: y)) })
    }
}
