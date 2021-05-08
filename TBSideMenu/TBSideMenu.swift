//
//  TBSideMenu.swift
//  TBSideMenu
//
//  Created by Bang Nguyen on 9/5/21.
//

import UIKit

enum MenuState: Int {
  case hide
  case show
}

protocol TBSideMenu {
    var menuState: MenuState { get set }
    var menuVC: UIViewController { get }
}

private enum Consts {
    static var menuStateKey: UInt8 = 0
}

extension TBSideMenu where Self: UIViewController {
    var menuState: MenuState {
        get {
            return (objc_getAssociatedObject(self, &Consts.menuStateKey) as? MenuState) ?? .hide
        }
        set {
            objc_setAssociatedObject(self, &Consts.menuStateKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func setupMenu() {
        guard let window = view.window, menuVC.view.superview == nil else { return }

        window.backgroundColor = UIColor.UIColorFromRGB(0x00AAC8)
        window.insertSubview(menuVC.view, at: 0)
        var frame = view.frame
        frame.origin.x -= frame.width
        menuVC.view.frame = frame
    }
    
    func move(_ right: Bool) {
      let w = self.view.frame.width
      if right {
        menuVC.view.transform = CGAffineTransform.init(translationX: w, y: 0)
        let shift2 = CGAffineTransform.init(translationX: w * 0.86, y: 0)
        view.transform = CGAffineTransform.init(scaleX: 1, y: 0.71).concatenating(shift2)
        view.layer.cornerRadius = 20
      } else {
        menuVC.view.transform = .identity
        view.transform = .identity
        view.layer.cornerRadius = 0
      }
    }
    
    func toggleMenu() {
        switch self.menuState {
        case .hide:
          self.menuState = .show
          self.move(true)
        case .show:
          self.menuState = .hide
          self.move(false)
        }
    }
}
