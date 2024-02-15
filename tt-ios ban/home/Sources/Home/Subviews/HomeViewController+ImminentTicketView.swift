//
//  HomeViewController+ImminentTicketView.swift
//  home
//
//  Created by 오연서 on 1/21/24.
//

import UIKit

extension HomeViewController {
    final class ImminentTicketView: BaseView {

        
        
        // MARK: - View
        
        // "마감 임박 티켓"
        lazy var ticketText: UILabel = {
            let label = UILabel()
            label.text = "마감 임박 티켓"
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
            label.textColor = UIColor(named: "서브 텍스트 1")
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            return label
        }()
        
        // 마감임박 티켓
        private lazy var imminentTicketTableViewController: TicketTableViewController = {
            let tableViewController = TicketTableViewController()
            return tableViewController
        }()
        
        // 최근 편집한 프로젝트가 없음
        lazy var ticketNone: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "image2")
            view.contentMode = .scaleAspectFit
            view.clipsToBounds = true
            return view
        }()
        
        // 아직 받은 티켓이 없어요.
        lazy var ticketNoneText1: UILabel = {
            let label = UILabel()
            label.text = "아직 받은 티켓이 없어요."
            label.font = UIFont(name: "Inter-SemiBold", size: 17)
            label.textColor = UIColor(named: "서브 텍스트 3")
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            return label
        }()
        
        // 팀원들과 해야 할 일을 티켓으로 주고받아보세요.
        lazy var ticketNoneText2: UILabel = {
            let label = UILabel()
            label.text = "팀원들과 해야 할 일을 티켓으로 주고받아보세요."
            label.font = UIFont(name: "Inter-Medium", size: 12)
            label.textColor = UIColor(named: "기본 테두리")
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            return label
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
            backgroundColor = .white
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            addSubview(ticketText)

//            addSubview(ticketNone)
//            addSubview(ticketNoneText1)
//            addSubview(ticketNoneText2)
            
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            ticketText.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(22)
                make.left.equalToSuperview().inset(21)
            }
            
//            graybox.snp.makeConstraints { make in
//                make.top.equalTo(ticketText.snp.bottom).offset(10)
//                make.leading.trailing.equalToSuperview()
//                make.height.equalTo(500)
//            }
            
//            ticketNone.snp.makeConstraints { make in
//                make.top.equalTo(ticketText.snp.bottom).offset(30)
//                make.centerX.equalToSuperview()
//            }
//            
//            ticketNoneText1.snp.makeConstraints { make in
//                make.top.equalTo(ticketNone.snp.bottom).offset(10)
//                make.centerX.equalToSuperview()
//            }
//            
//            ticketNoneText2.snp.makeConstraints { make in
//                make.top.equalTo(ticketNoneText1.snp.bottom).offset(7)
//                make.centerX.equalToSuperview()
//            }
        }
    }
}
