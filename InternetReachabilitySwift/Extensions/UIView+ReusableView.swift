//
//  UIView+ReusableView.swift
//  HillRom
//
//  Created by Y Media Labs on 12/11/16.
//  Copyright © 2017 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: AnyObject {
   static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
         return String(describing: self)
    }
}


protocol NibLoadableView: ReusableView {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
         return String(describing: self)
    }
}

