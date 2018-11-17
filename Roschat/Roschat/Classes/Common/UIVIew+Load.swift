//
//  UIVIew+Load.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib() -> Self {
        return rx_loadFromNib()
    }
}

extension UIView {
    
    private enum Axis: String {
        case vertical = "V"
        case horizontal = "H"
    }
    
    func fillView(
        _ viewToFill: UIView? = nil,
        padding: CGFloat,
        priority: UILayoutPriority = UILayoutPriority.required) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let edgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        fillView(viewToFill, insets: edgeInsets)
    }
    
    func fillView(
        _ viewToFill: UIView? = nil,
        insets: UIEdgeInsets = UIEdgeInsets.zero,
        priority: UILayoutPriority = UILayoutPriority.required) {
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let viewToFill = viewToFill ?? superview else {
            return
        }
        
        viewToFill.addConstraints(
            constructPaddings(.vertical,
                              values: CGPoint(x: insets.top, y: insets.bottom),
                              priority: priority))
        
        viewToFill.addConstraints(
            constructPaddings(.horizontal, values:
                CGPoint(x: insets.left, y: insets.right),
                              priority: priority))
    }
    
    func makeCenter(_ toView: UIView? = nil, constant: CGFloat = 0.0) {
        makeCenterX(toView, constant: constant)
        makeCenterY(toView, constant: constant)
    }
    
    func makeCenterX(_ toView: UIView? = nil, constant: CGFloat = 0.0) {
        makeEqual(toView ?? superview, attribute: .centerX, constant: constant)
    }
    
    func makeCenterY(_ toView: UIView? = nil, constant: CGFloat = 0.0) {
        makeEqual(toView ?? superview, attribute: .centerY, constant: constant)
    }
    
    @discardableResult
    func makeLeadingTo(_ toView: UIView? = nil,
                       relatedBy: NSLayoutConstraint.Relation = .equal,
                       constant: CGFloat = 0.0,
                       priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
        return make(
            toView ?? superview,
            attribute: .leading,
            relatedBy: relatedBy,
            constant: constant)
    }
    
    @discardableResult
    func makeTrailingTo(_ toView: UIView? = nil,
                        relatedBy: NSLayoutConstraint.Relation = .equal,
                        constant: CGFloat = 0.0,
                        priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
        return make(
            toView ?? superview,
            attribute: .trailing,
            relatedBy: relatedBy,
            constant: constant)
    }
    
    @discardableResult
    func makeTopTo(_ toView: UIView? = nil,
                   relatedBy: NSLayoutConstraint.Relation = .equal,
                   constant: CGFloat = 0.0,
                   priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
        return make(
            toView ?? superview,
            attribute: .top,
            relatedBy: relatedBy,
            constant: constant)
    }
    
    @discardableResult
    func makeBottomTo(_ toView: UIView? = nil,
                      relatedBy: NSLayoutConstraint.Relation = .equal,
                      constant: CGFloat = 0.0,
                      priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
        return make(
            toView ?? superview,
            attribute: .bottom,
            relatedBy: relatedBy,
            constant: constant)
    }
    
    @discardableResult
    func makeHeight(
        _ toView: UIView? = nil,
        relatedBy: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0.0) -> NSLayoutConstraint {
        return make(
            toView,
            attribute: .height,
            toAttribute: toView == .none ? .notAnAttribute : .height,
            relatedBy: relatedBy,
            constant: constant)
    }
    
    @discardableResult
    func makeWidth(_ toView: UIView? = nil,
                   relatedBy: NSLayoutConstraint.Relation = .equal,
                   constant: CGFloat = 0.0) -> NSLayoutConstraint {
        return make(
            toView,
            attribute: .width,
            toAttribute: toView == .none ? .notAnAttribute : .width,
            relatedBy: relatedBy,
            constant: constant)
    }
    
    func makeEqual(
        _ toView: UIView? = nil,
        attribute: NSLayoutConstraint.Attribute,
        toAttribute: NSLayoutConstraint.Attribute? = nil,
        constant: CGFloat = 0.0) {
        let toAttribute = toAttribute ?? attribute
        
        make(toView ?? superview,
             attribute: attribute,
             toAttribute: toAttribute,
             relatedBy: .equal,
             constant: constant)
    }
    
    func makeGreaterThanOrEqual(
        _ toView: UIView? = nil,
        attribute: NSLayoutConstraint.Attribute,
        toAttribute: NSLayoutConstraint.Attribute? = nil,
        constant: CGFloat = 0.0) {
        let toAttribute = toAttribute ?? attribute
        
        make(toView ?? superview,
             attribute: attribute,
             toAttribute: toAttribute,
             relatedBy: .greaterThanOrEqual,
             constant: constant)
    }
    
    func makeLessThanOrEqual(
        _ toView: UIView? = nil,
        attribute: NSLayoutConstraint.Attribute,
        toAttribute: NSLayoutConstraint.Attribute? = nil,
        constant: CGFloat = 0.0) {
        let toAttribute = toAttribute ?? attribute
        
        make(toView ?? superview,
             attribute: attribute,
             toAttribute: toAttribute,
             relatedBy: .lessThanOrEqual,
             constant: constant)
    }
    
    // MARK: - Приватные функции
    
    private func constructPaddings(
        _ axis: Axis,
        values: CGPoint,
        priority: UILayoutPriority = UILayoutPriority.required) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(
            withVisualFormat: axis.rawValue + ":|-left@priority-[view]-right@priority-|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: ["left": values.x, "right": values.y, "priority": priority],
            views: ["view": self])
    }
    
    @discardableResult
    private func make(
        _ toView: UIView? = nil,
        attribute: NSLayoutConstraint.Attribute,
        toAttribute: NSLayoutConstraint.Attribute? = nil,
        relatedBy: NSLayoutConstraint.Relation,
        constant: CGFloat = 0.0,
        priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        
        let toAttribute = toAttribute ?? attribute
        
        let ownerView = toView ?? self
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: relatedBy,
            toItem: toView,
            attribute: toAttribute,
            multiplier: 1.0,
            constant: constant)
        
        constraint.priority = priority
        
        ownerView.addConstraint(constraint)
        
        return constraint
    }
    
}

