//
//  UIView+Animations.swift
//  ViewAnimations
//
//  Created by Alex da Franca on 09.08.17.
//  Copyright © 2017 Farbflash. All rights reserved.
//

import UIKit

public extension UIView {

    @discardableResult func animate(_ animations: Animation...) -> AnimationToken {
        return animate(animations)
    }

    @discardableResult func animate(_ animations: [Animation]) -> AnimationToken {
        return AnimationToken(
            view: self,
            animations: animations,
            mode: .inSequence
        )
    }

    @discardableResult func animate(inParallel animations: Animation...) -> AnimationToken {
        return animate(inParallel: animations)
    }

    @discardableResult func animate(inParallel animations: [Animation]) -> AnimationToken {
        return AnimationToken(
            view: self,
            animations: animations,
            mode: .inParallel
        )
    }
}
