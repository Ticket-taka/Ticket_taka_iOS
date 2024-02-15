//
//  HomeViewController+TopView.swift
//  home
//
//  Created by 오연서 on 1/18/24.
//

import UIKit

extension HomeViewController {
    final class HomeTopView: BaseView {
        
        // MARK: - View
        
        // Ticket-Taka 에 오신 것을 환영합니다.
        lazy var welcomeText: UILabel = {
            let label = UILabel()
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            let baseAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "SFProDisplay-Medium", size: 27) ?? UIFont.systemFont(ofSize: 27)]
            let attributedText = NSMutableAttributedString(string: "NAME 님,\nTicket-Taka 에\n오신 것을 환영합니다.", attributes: baseAttributes)
            
            // 줄 간의 간격 조정
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
            
            // "(이름)"에 대한 폰트 지정
            attributedText.addAttribute(.font, value: UIFont(name: "SFProDisplay-Semibold", size: 27) ?? UIFont.systemFont(ofSize: 27), range: NSRange(location: 0, length: 5))
            
            // "Ticket-Taka"에 대한 폰트 지정
            attributedText.addAttribute(.font, value: UIFont(name: "SFProDisplay-Semibold", size: 27) ?? UIFont.systemFont(ofSize: 27), range: NSRange(location: 7, length: 12))
            
            label.attributedText = attributedText
            label.textAlignment = .left
            label.numberOfLines = 3
            
            return label
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
            backgroundColor = UIColor(named:"메뉴 배경 1")
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            addSubview(welcomeText)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            welcomeText.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(46)
                make.leading.trailing.equalToSuperview().inset(20)
            }
        }
    }
}
