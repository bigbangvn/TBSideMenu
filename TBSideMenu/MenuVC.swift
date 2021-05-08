//
//  MenuVC.swift
//  TBSideMenu
//
//  Created by Bang Nguyen on 9/5/21.
//

import SnapKit

protocol MenuVCDelegate: AnyObject {
    func tapMenuItem(_ item: MenuItem)
    func tapToDismiss()
}

enum MenuItem {
    case profile
    case findPartner
    case userRanking
    case idiomsGame
    case feedback
    case fanpage
}

final class MenuVC: UIViewController {
    weak var delegate: MenuVCDelegate?
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.UIColorFromRGB(0x00AAC8)
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 35.5
        zip(
        [MenuItem.profile, .findPartner, .userRanking, .idiomsGame, .feedback, .fanpage],
        ["Profile", "Find partner", "User ranking", "Idioms game", "Feedback", "Fanpage"]).forEach { (type, str) in
            stackView.addArrangedSubview(MenuItemView(text: str, tapCallback: { [weak self] in
                print(str)
                self?.delegate?.tapMenuItem(type)
            }))
        }
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func didTap() {
        delegate?.tapToDismiss()
    }
}

final class MenuItemView: UIView {
    private let lb = UILabel()
    private let tapCallback: () -> Void
    
    init(text: String, tapCallback: @escaping () -> Void) {
        self.tapCallback = tapCallback
        super.init(frame: .zero)
        backgroundColor = .clear
        lb.textColor = .white
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.text = text
        
        addSubview(lb)
        lb.snp.makeConstraints { $0.edges.equalToSuperview() }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(gesture)
    }
    
    @objc private func didTap() {
        tapCallback()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
