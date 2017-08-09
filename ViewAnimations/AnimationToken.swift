//
//  AnimationToken.swift
//  ViewAnimations
//
//  Created by Alex da Franca on 09.08.17.
//  Copyright © 2017 Farbflash. All rights reserved.
//

import UIKit

// global functions to animate an array of animations

public func animate(_ tokens: AnimationToken...) {
    animate(tokens)
}

public func animate(_ tokens: [AnimationToken]) {
    guard !tokens.isEmpty else {
        return
    }

    var tokens = tokens
    let token = tokens.removeFirst()

    token.perform {
        animate(tokens)
    }
}


// We add an enum to describe in which mode we want to animate
internal enum AnimationMode {
    case inSequence
    case inParallel
}

public final class AnimationToken {
    private let view: UIView
    private let animations: [Animation]
    private let mode: AnimationMode
    private var isValid = true

    // We don't want the API user to think that they should create tokens
    // themselves, so we make the initializer internal to the framework
    internal init(view: UIView, animations: [Animation], mode: AnimationMode) {
        self.view = view
        self.animations = animations
        self.mode = mode
    }

    deinit {
        // Automatically perform the animations when the token gets deallocated
        perform {}
    }

    internal func perform(completionHandler: @escaping () -> Void) {
        // To prevent the animation from being executed twice, we invalidate
        // the token once its animation has been performed
        guard isValid else {
            return
        }

        isValid = false

        switch mode {
        case .inSequence:
            view.performAnimations(animations,
                                   completionHandler: completionHandler)
        case .inParallel:
            view.performAnimationsInParallel(animations,
                                             completionHandler: completionHandler)
        }
    }
}

internal extension UIView {
    func performAnimations(_ animations: [Animation], completionHandler: @escaping () -> Void) {
        // This implementation is exactly the same as before, only now we call
        // the completion handler when our exit condition is hit
        guard !animations.isEmpty else {
            return completionHandler()
        }

        var animations = animations
        let animation = animations.removeFirst()

        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        }, completion: { _ in
            self.performAnimations(animations, completionHandler: completionHandler)
        })
    }

    func performAnimationsInParallel(_ animations: [Animation], completionHandler: @escaping () -> Void) {
        // If we have no animations, we can exit early
        guard !animations.isEmpty else {
            return completionHandler()
        }

        // In order to call the completion handler once all animations
        // have finished, we need to keep track of these counts
        var animationCount = animations.count

        let animationCompletionHandler = {
            animationCount -= 1

            // Once all animations have finished, we call the completion handler
            if animationCount < 1 {
                completionHandler()
            }
        }

        // Same as before, only with the call to the animation
        // completion handler added
        for animation in animations {
            UIView.animate(withDuration: animation.duration, animations: {
                animation.closure(self)
            }, completion: { _ in
                animationCompletionHandler()
            })
        }
    }
}
