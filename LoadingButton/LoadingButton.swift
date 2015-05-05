//
//  LoadingButton.swift
//  ProductHunt
//
//  Created by Raúl Riera on 26/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

public class LoadingButton: UIButton {

    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    private var lastKnownTitle: String?
    /// A Boolean value indicating whether a loading operation has been triggered and is in progress. (read-only)
    public var loading: Bool {
        return activityIndicator.isAnimating()
    }

    /**
    Tells the control that a loading operation was started programmatically.

    Call this method when an external event source triggers a programmatic loading event. This method updates the state of the button control to reflect the in-progress loading operation. When the loading operation ends, be sure to call the endLoading method to return the control to its default state.
    */
    public func beginLoading() {
        lastKnownTitle = currentTitle
        setTitle("", forState: .Normal)
        activityIndicator.startAnimating()
        enabled = false
    }

    /**
    Tells the control that a loading operation has ended.

    Call this method at the end of any loading operation (whether it was initiated programmatically or by the user) to return the button control to its default state. Calling this method also hides it.
    */
    public func endLoading() {
        setTitle(lastKnownTitle, forState: .Normal)
        activityIndicator.stopAnimating()
        enabled = true
    }

    private func configureActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(activityIndicator)

        addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
    }

    // MARK: Overrides

    public override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        super.endTrackingWithTouch(touch, withEvent:event)

        if touch.tapCount > 0 {
            beginLoading()
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        configureActivityIndicator()
    }

}
