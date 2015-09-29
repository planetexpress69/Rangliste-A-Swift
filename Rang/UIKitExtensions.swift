//
//  UIImageExtensions.swift
//  Rang
//
//  Created by Martin Kautz on 20.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

// -------------------------------------------------------------------------------------------------
// MARK: - UIImage extension
// -------------------------------------------------------------------------------------------------
public extension UIImage {

    // ---------------------------------------------------------------------------------------------
    public class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), true, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// -------------------------------------------------------------------------------------------------
// MARK: - UINavigationBar extension
// -------------------------------------------------------------------------------------------------
public extension UINavigationBar {

    // ---------------------------------------------------------------------------------------------
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = true
    }

    // ---------------------------------------------------------------------------------------------
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = false
    }

    // ---------------------------------------------------------------------------------------------
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKindOfClass(UIImageView) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }

        let subviews = (view.subviews )
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        return nil
    }
}

// -------------------------------------------------------------------------------------------------
// MARK: - UIToolbar extension
// -------------------------------------------------------------------------------------------------
public extension UIToolbar {

    // ---------------------------------------------------------------------------------------------
    func hideHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(self)
        navigationBarImageView!.hidden = true
    }

    // ---------------------------------------------------------------------------------------------
    func showHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(self)
        navigationBarImageView!.hidden = false
    }

    // ---------------------------------------------------------------------------------------------
    private func hairlineImageViewInToolbar(view: UIView) -> UIImageView? {
        if view.isKindOfClass(UIImageView) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }

        let subviews = (view.subviews )
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInToolbar(subview) {
                return imageView
            }
        }
        return nil
    }
}

// -------------------------------------------------------------------------------------------------
// MARK: - UINavigationController extension
// -------------------------------------------------------------------------------------------------
public extension UINavigationController {

    // ---------------------------------------------------------------------------------------------
    public override func childViewControllerForStatusBarHidden() -> UIViewController? {
        return self.topViewController
    }

    // ---------------------------------------------------------------------------------------------
    public override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.topViewController
    }
}


