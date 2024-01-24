//
//  AlarmViewController.swift
//  home
//
//  Created by 오연서 on 1/16/24.
//

import UIKit
import SnapKit

class AlarmViewController: UIViewController {
    
    private var notifications: [Notification] = [
        Notification(type: .ticketReceiveAgain,
            message: "이준영 님이 티켓을 다시 요청했어요!",
                             submessage: "Ticket-Taka 팀",
                             time: "1분 전",
                             image: UIImage(named: "icon_ticket")!,
                             hasViewButton: true),
        Notification(type: .feedbackRequest,
            message: "이준영 님이 티켓 피드백 요청을 보냈어요!",
                     submessage: "Ticket-Taka 팀",
                     time: "1분 전",
                     image: UIImage(named: "icon_ticket")!,
                     hasViewButton: true),
        Notification(type: .teamInvite,
            message: "새로운 팀 초대가 도착했어요!",
                         submessage: "Ticket-Taka 팀",
                         time: "2분 전",
                         image: UIImage(named: "icon_ticket")!,
                         hasViewButton: false),
        Notification( type: .ticketReceive,
            message: "김두현 님이 티켓을 보냈어요!",
                             submessage: "UMC 5th TT팀에서 확인해보세요.",
                             time: "3분 전",
                             image: UIImage(named: "icon_ticket")!,
                             hasViewButton: true)]
    
    // UIScrollView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
                    self.navigationController?.popViewController(animated: true)
            }))
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    // "알림"
    lazy var alarmText: UILabel = {
        let label = UILabel()
        label.text = "알림"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 27)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    // 회색 선
    lazy var grayline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Cool gray 3")
        return view
    }()
    
    
    // 알람 목록
    lazy var alarmCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        return view
        }()
    
    func collectionviewSet(){
        self.alarmCollectionView.dataSource = self
        self.alarmCollectionView.delegate = self
        self.alarmCollectionView.register(AlarmViewController.AlarmViewCell.self, forCellWithReuseIdentifier: "NotificationCell")
        self.alarmCollectionView.backgroundColor = .white
    }
    
    func addView() {
        self.view.addSubview(scrollView)
        [backButton, alarmText, grayline, alarmCollectionView].forEach { view in scrollView.addSubview(view)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addView()
        collectionviewSet()
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
        }
        
        alarmText.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(7)
            make.left.equalToSuperview().offset(30)
        }
        
        grayline.snp.makeConstraints { make in
            make.top.equalTo(alarmText.snp.bottom).offset(15)
            make.leading.trailing.equalTo(scrollView)
            make.height.equalTo(13)
            make.width.equalToSuperview()
        }
        
        alarmCollectionView.snp.makeConstraints { make in
            make.top.equalTo(grayline.snp.bottom).offset(15)
            make.center.equalToSuperview()
            make.height.equalTo(500)
            make.width.equalTo(self.view.frame.width - 20)
        }
    }
    
    func notificationCount() -> Int {
        return notifications.count
    }
}

extension AlarmViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotificationCell", for: indexPath) as? AlarmViewCell else {
                    return UICollectionViewCell()
                }
                let notification = notifications[indexPath.item]
                cell.configure(with: notification)
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = alarmCollectionView.frame.width - 10
        let height: CGFloat = 100
        return CGSize(width: width, height: height)
    }
}

