//
//  AlarmViewCell.swift
//  home
//
//  Created by 오연서 on 1/17/24.
//

import UIKit

extension AlarmViewController {
    final class AlarmViewCell: BaseCollectionViewCell {
        
        
        // MARK: - Property
        
        private var alarm: Notification! {
            didSet {
                update()
            }
        }
        
        // MARK: - View
        
        // 알람 정보 1
        lazy var titleLable: UILabel = {
            let view = UILabel()
            view.font = UIFont(name: "SFProDisplay-Medium", size: 14)
            view.numberOfLines = 1
            view.textColor = UIColor(named: "서브 텍스트 1")
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .left
            
            return view
        }()
        
        // 알람 정보 2
        lazy var secondtitleLable: UILabel = {
            let view = UILabel()
            view.font = UIFont(name: "SFProDisplay-SemiBold", size: 14)
            view.numberOfLines = 1
            view.textColor = UIColor(named: "서브 텍스트 1")
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .left
            
            return view
        }()
        
        // 시간 정보
        lazy var timeLable: UILabel = {
            let view = UILabel()
            view.text = "1시간 전"
            view.font = UIFont(name: "SFProDisplay-Medium", size: 14)
            view.numberOfLines = 1
            view.textColor = UIColor(named: "서브 텍스트 1_3")
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .left
            
            return view
        }()
        
        // 티켓 아이콘
        lazy var ticketImage: UIImageView = {
            let view = UIImageView()
            view.sizeToFit()
            return view
        }()
        
        //보기 버튼
        lazy var viewButton: UIButton = {
            let view = UIButton()
            view.backgroundColor = UIColor(named: "활성화 테두리")
            view.setTitle("보기", for: .normal)
            view.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 13)
            view.setTitleColor(.white, for: .normal)
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        //거절 버튼
        lazy var declineButton: UIButton = {
            let view = UIButton()
            view.backgroundColor = UIColor(named: "Cool gray 1")
            view.setTitle("거절", for: .normal)
            view.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 13)
            view.setTitleColor(.black, for: .normal)
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        //수락 버튼
        lazy var acceptButton: UIButton = {
            let view = UIButton()
            view.backgroundColor = UIColor(named: "활성화 테두리")
            view.setTitle("수락", for: .normal)
            view.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 13)
            view.setTitleColor(.white, for: .normal)
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        
        // MARK: - UI
        
        override func prepare() {
            
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            [titleLable, secondtitleLable, timeLable, ticketImage, viewButton, declineButton, acceptButton].forEach { view in addSubview(view)}
            self.backgroundColor = UIColor(named: "Cool gray 4")
        }
        
        
        override func configureConstraints() {
            super.configureConstraints()
            
            titleLable.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(15)
                make.leading.equalToSuperview().offset(23)
            }
            
            timeLable.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().inset(20)
            }
            
            ticketImage.snp.makeConstraints { make in
                make.top.equalTo(titleLable.snp.bottom).offset(25)
                make.leading.equalToSuperview().offset(30)
            }
            
            secondtitleLable.snp.makeConstraints { make in
                make.top.equalTo(titleLable.snp.bottom).offset(29)
                make.leading.equalToSuperview().offset(80)
            }
            
            viewButton.snp.makeConstraints { make in
                make.centerY.equalTo(secondtitleLable.snp.centerY)
                make.trailing.equalTo(timeLable.snp.trailing)
                make.height.equalTo(28)
                make.width.equalTo(60)
            }
            
            declineButton.snp.makeConstraints { make in
                make.centerY.equalTo(secondtitleLable.snp.centerY)
                make.trailing.equalTo(timeLable.snp.trailing).inset(65)
                make.height.equalTo(28)
                make.width.equalTo(60)
            }
            
            acceptButton.snp.makeConstraints { make in
                make.centerY.equalTo(secondtitleLable.snp.centerY)
                make.trailing.equalTo(timeLable.snp.trailing)
                make.height.equalTo(28)
                make.width.equalTo(60)
            }
            
            
        }
        
        override func update() {
            super.update()
            
            titleLable.text = alarm.message
            secondtitleLable.text = alarm.submessage
            ticketImage.image = alarm.image
            timeLable.text = alarm.time
            
            viewButton.isHidden = !alarm.hasViewButton
            
            declineButton.isHidden = alarm.hasViewButton
            acceptButton.isHidden = alarm.hasViewButton
            
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
                layer.cornerRadius = 20
                layer.masksToBounds = true
        }
        
        func configure(with alarm: Notification) {
            self.alarm = alarm
        }
    }
}

extension AlarmViewController.AlarmViewCell {
    static func makeCell(to view: UICollectionView, indexPath: IndexPath, alarm: Notification) -> AlarmViewController.AlarmViewCell {
        guard let cell = view.dequeueReusableCell(
            withReuseIdentifier: AlarmViewController.AlarmViewCell.reuseIdentifier,
            for: indexPath
        ) as? AlarmViewController.AlarmViewCell else { fatalError("Cell is not registered to view....") }
        cell.configure(with: alarm)
        return cell
    }
}


