//
//  ViewController.swift
//  TBSideMenu
//
//  Created by Bang Nguyen on 9/5/21.
//

import UIKit

class ViewController: UIViewController, TBSideMenu {
    private(set) lazy var menuVC: UIViewController = {
      let vc = MenuVC()
        vc.delegate = self
      return vc
    }()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .green
      
      let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
      view.addGestureRecognizer(tap)
    }
    
    @objc private func didTap() {
        UIView.animate(withDuration: 0.3) {
            self.toggleMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      setupMenu()
    }
    
    deinit {
      menuVC.view.removeFromSuperview()
    }
}

extension ViewController: MenuVCDelegate {
    func tapMenuItem(_ item: MenuItem) {
        didTap()
        print("Tap item: \(item)")
    }
    
    func tapToDismiss() {
        didTap()
    }
}
