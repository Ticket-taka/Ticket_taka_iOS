//
//  NewTeamViewController+TeamIconView.swift
//  home
//
//  Created by 반성준 on 2024/01/17.
//

import UIKit

extension NewTeamViewController {
    final class TeamIconView: BaseView {
        
        // MARK: - View
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "팀 아이콘"
            return label
        }()
        
        lazy var defaultIconView: IconView = {
            IconView(imageName: UIImage(named:"icon_team")!, bgColor: UIColor(named: "Primary color")!, text: "기본")
        }()
        
        lazy var addPhotoView: IconView = {
            IconView(imageName: UIImage(named:"icon_photo")!, bgColor: UIColor(named: "Cool gray 5")!, text: "사진 추가")
        }()
        
        // MARK: - UI
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(titleLabel)
            addSubview(defaultIconView)
            addSubview(addPhotoView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.bottom.equalTo(defaultIconView)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
            }
            
            defaultIconView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(9)
                make.leading.equalToSuperview()
            }
            
            addPhotoView.snp.makeConstraints { make in
                make.top.equalTo(defaultIconView)
                make.leading.equalTo(defaultIconView.snp.trailing).offset(11)
            }
        }
    }
}

extension NewTeamViewController {
    final class IconView: BaseControl {
        
        // MARK: - Property
        
        var imageName: UIImage? {
            didSet { update() }
        }
        var bgColor: UIColor? {
            didSet { update() }
        }
        var text: String? {
            didSet { update() }
        }
        
        // MARK: - View
        
        lazy var iconContainerView: UIView = {
            // MARK: - RxSwift Bug, UIView is not handled
            let view = UIImageView()
            view.layer.borderWidth = 2
            view.layer.borderColor = UIColor(named: "grey")?.cgColor//UIColor(named: "Point")?.cgColor
            view.layer.cornerRadius = 22
            view.layer.masksToBounds = true
            return view
        }()
        
        
        lazy var iconView: UIImageView = {
            UIImageView(image: UIImage(named: "icon_team"))
        }()
        
        lazy var addIconView: UIImageView = {
            UIImageView(image: UIImage(named: "icon_team"))
        }()
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(named: "서브 텍스트 1")
            
            return label
        }()
        
        // MARK: - Init
        
        convenience init(imageName: UIImage, bgColor: UIColor, text: String) {
            defer {
                self.imageName = imageName
                self.bgColor = bgColor
                self.text = text
            }
            
            self.init(frame: .zero)
        }
        
        // MARK: - UI
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(iconContainerView)
            iconContainerView.addSubview(iconView)
            iconContainerView.addSubview(addIconView)
            addSubview(titleLabel)
            
            addIconView.isHidden = true
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.leading.trailing.equalTo(iconContainerView)
                make.bottom.equalTo(titleLabel)
            }
            
            iconContainerView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
                make.width.height.equalTo(44)
            }
            
            iconView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.height.equalTo(24)
            }
            
            addIconView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(iconContainerView.snp.bottom).offset(5)
                make.centerX.equalToSuperview()
            }
        }
        
        // MARK: - Bind
        
        override func update() {
            super.update()
            iconView.image = imageName
            iconContainerView.backgroundColor = bgColor
            titleLabel.text = text
        }
    }
}
