//
//  CalendarViewController+MyCalenderView.swift
//  home
//
//  Created by 오연서 on 1/23/24.
//

import UIKit

extension MyCalendarViewController {
    final class CalendarMonthView: BaseView {
        
        
        // MARK: - View
        
        private lazy var stackView: UIStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.alignment = .center
            view.layer.cornerRadius = 25
            view.backgroundColor = UIColor(named: "활성화 테두리")
            view.spacing = 25
            view.distribution = .equalCentering
            return view
        }()
        
        lazy var backButton: UIButton = {
            let button = UIButton()
            let image = UIImage(named: "icon_left")?.withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 15
            button.tintColor = UIColor(named: "활성화 테두리")
            return button
        }()
        
        lazy var forwardButton: UIButton = {
            let button = UIButton()
            let image = UIImage(named: "icon_right")?.withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 15
            button.tintColor = UIColor(named: "활성화 테두리")
            return button
        }()
        
        lazy var monthLabel: UILabel = {
            let view = UILabel()
            view.text = "January"
            view.textColor = .white
            view.textAlignment = .center
            return view
        }()
        
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            addSubview(stackView)
            [backButton, monthLabel, forwardButton].forEach {view in stackView.addArrangedSubview(view)}
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            backButton.snp.makeConstraints { make in
                make.height.width.equalTo(30)
                make.leading.equalToSuperview().inset(10)
            }
            
            forwardButton.snp.makeConstraints { make in
                make.height.width.equalTo(30)
                make.trailing.equalToSuperview().inset(10)
            }
        }
    }
}

