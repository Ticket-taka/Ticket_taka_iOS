//
//  RecentProjectCollectionViewCell.swift
//  home
//
//  Created by 오연서 on 1/23/24.
//

import UIKit

extension HomeViewController {
    enum RecentProjectCollectionViewCellType {
        case addButton
        case project
    }
    
    final class RecentProjectCollectionViewCell: BaseCollectionViewCell {
        
        static let identifier = "recentProjectCollectionViewCell"
        
        // MARK: - Property
        
        var cellType: RecentProjectCollectionViewCellType = .project {
            didSet {
                update()
            }
        }
        
        var title: String? {
            didSet {
                update()
            }
        }
        
        var projectCardImage: UIImage? {
            didSet {
                update()
            }
        }
        
        override var isSelected: Bool {
            didSet {
                selected()
            }
        }
        
        // MARK: - View
        
        private var mainContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.clipsToBounds = true
            view.layer.cornerRadius = 10
            return view
        }()
        
        private var projectCardImageView: UIImageView = {
            let imageView = UIImageView()
            return imageView
        }()
        
        private var titleContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        
        private var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 13)
            label.textColor = UIColor(hexCode: "545454")
            return label
        }()
        
        private var plusIconView: IconComponent = {
            let iconView = IconComponent(imageName: "icon_team_plus",
                                         bgColor: .clear,
                                         imageSize: 34,
                                         containerSize: 34)
            iconView.isHidden = true
            return iconView
        }()
        
        private var dimmedView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "33315B", alpha: 0.5)
            view.isHidden = true
            return view
        }()
        
        private var checkIcon: UIImageView = {
            UIImageView(image: UIImage(named: "icon_check"))
        }()
        
        // MARK: - UI
        
        override func prepare() {
            layer.cornerRadius = 10
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowColor = UIColor(hexCode: "000000", alpha: 0.25).cgColor
            layer.shadowRadius = 5
            layer.shadowOpacity = 1
            layer.masksToBounds = false
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            titleContainerView.addSubview(titleLabel)
            mainContainerView.addSubview(projectCardImageView)
            mainContainerView.addSubview(titleContainerView)
            mainContainerView.addSubview(plusIconView)
            
            dimmedView.addSubview(checkIcon)
            mainContainerView.addSubview(dimmedView)
            
            contentView.addSubview(mainContainerView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            mainContainerView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
            
            projectCardImageView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
            
            titleContainerView.snp.makeConstraints { make in
                make.height.equalTo(40)
                make.leading.trailing.bottom.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(12)
            }
            
            plusIconView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            dimmedView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
            
            checkIcon.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
        
        override func update() {
            super.update()
            
            switch cellType {
            case .addButton:
                titleLabel.isHidden = true
                projectCardImageView.isHidden = true
                titleContainerView.isHidden = true
                plusIconView.isHidden = false
            case .project:
                titleLabel.text = title
                projectCardImageView.image = projectCardImage
            }
        }
        
        func selected() {
            
            //화면전환 구현
        }
    }
}

extension HomeViewController.RecentProjectCollectionViewCell {
    static func makeCell(to view: UICollectionView, indexPath: IndexPath,
                         title: String,
                         cardImage: UIImage?) -> HomeViewController.RecentProjectCollectionViewCell {
        guard let cell = view.dequeueReusableCell(
            withReuseIdentifier: HomeViewController.RecentProjectCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? HomeViewController.RecentProjectCollectionViewCell else {
            fatalError("Cell is not registered to view....")
        }
        cell.title = title
        cell.projectCardImage = cardImage
        return cell
    }
    
    static func makeCell(to view: UICollectionView, indexPath: IndexPath) -> HomeViewController.RecentProjectCollectionViewCell {
        guard let cell = view.dequeueReusableCell(
            withReuseIdentifier: HomeViewController.RecentProjectCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? HomeViewController.RecentProjectCollectionViewCell else {
            fatalError("Cell is not registered to view....")
        }

        cell.cellType = .addButton
        return cell
    }
}
