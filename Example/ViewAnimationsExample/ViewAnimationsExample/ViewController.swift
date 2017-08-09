//
//  ViewController.swift
//  ViewAnimationsExample
//
//  Created by Alex da Franca on 09.08.17.
//  Copyright © 2017 Farbflash. All rights reserved.
//

import UIKit
import ViewAnimations

class ViewController: UIViewController {

    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var prompt: UILabel!

    private let animationDuration = TimeInterval(2)

    @IBAction func buttonAction(_ sender: Any) {
        animateView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // play two animations in sequence
        animate(
            prompt.animate(
                .fadeIn(duration: animationDuration),
                .move(byX: 0, y: -50, duration: animationDuration)
            ),
            button.animate(
                .fadeIn(duration: animationDuration)
            )
        )
    }

    private final func animateView() {

        // play two animations on one view in parallel
        targetView.animate(inParallel:
            .fadeIn(duration: animationDuration),
            .resize(to: CGSize(width: 200, height: 200), duration: animationDuration)
        )
    }
}

