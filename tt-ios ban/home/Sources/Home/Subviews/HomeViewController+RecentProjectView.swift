//
//  HomeViewController+RecentProjectView.swift
//  home
//
//  Created by 오연서 on 1/21/24.
//

import UIKit

extension HomeViewController {
    final class RecentProjectView: BaseView {
        
        // MARK: - View
        
        // "최근 편집한 프로젝트 바로가기"
        lazy var recentText: UILabel = {
            let label = UILabel()
            label.text = "최근 편집한 프로젝트 바로가기"
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
            label.textColor = UIColor(named: "서브 텍스트 1")
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            return label
        }()
        
        // 최근 편집한 프로젝트가 없음
        lazy var recentNone: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "image1")
            view.contentMode = .scaleAspectFit
            view.clipsToBounds = true
            return view
        }()
        
        // 아직 편집한 프로젝트가 없어요.
        lazy var recentNoneText1: UILabel = {
            let label = UILabel()
            label.text = "아직 편집한 프로젝트가 없어요."
            label.font = UIFont(name: "Inter-SemiBold", size: 17)
            label.textColor = UIColor(named: "서브 텍스트 3")
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            return label
        }()
        
        // 팀을 만들고 새로운 프로젝트를 시작해보세요.
        lazy var recentNoneText2: UILabel = {
            let label = UILabel()
            label.text = "팀을 만들고 새로운 프로젝트를 시작해보세요."
            label.font = UIFont(name: "Inter-Medium", size: 12)
            label.textColor = UIColor(named: "기본 테두리")
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            return label
        }()
        
        // 최근 편집한 프로젝트 목록
        lazy var recentProjectCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 30
            let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            return view
        }()
        
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
            backgroundColor = .white
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            addSubview(recentText)
//            addSubview(recentProjectCollectionView)
//            addSubview(recentNone)
//            addSubview(recentNoneText1)
//            addSubview(recentNoneText2)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            recentText.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(22)
                make.left.equalToSuperview().inset(21)
            }
            
//            recentNone.snp.makeConstraints { make in
//                make.top.equalTo(recentText.snp.bottom).offset(30)
//                make.centerX.equalToSuperview()
//            }
//            
//            recentNoneText1.snp.makeConstraints { make in
//                make.top.equalTo(recentNone.snp.bottom).offset(10)
//                make.centerX.equalToSuperview()
//            }
//            
//            recentNoneText2.snp.makeConstraints { make in
//                make.top.equalTo(recentNoneText1.snp.bottom).offset(7)
//                make.centerX.equalToSuperview()
//            }
            
        }
    }
}
