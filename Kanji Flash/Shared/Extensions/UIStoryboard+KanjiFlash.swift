//
//  UIStoryboard+KanjiFlash.swift
//  Kanji Flash
//
//  Created by Elex Lee on 11/20/19.
//  Copyright © 2019 Elex Lee. All rights reserved.
//

import UIKit

extension UIStoryboard {
    @nonobjc static let main = UIStoryboard(name: "Main", bundle: nil)
    @nonobjc static let kanjiList = UIStoryboard(name: "KanjiList", bundle: nil)

    /**
     For easy instantiation of view controllers
     
     Usage:
     
     `let myVC = UIStoryboard.myStoryboard.instantiate(from: MyVC.self)`
     */
    func instantiate<T: UIViewController>(from type: T.Type) -> T {
        return instantiateViewController(withIdentifier: type.storyboardId) as! T
    }
}
