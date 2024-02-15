//
//  MyCalendarViewController.swift
//  home
//
//  Created by 오연서 on 1/23/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa


class MyCalendarViewController: BaseViewController {
    
    
    // MARK: - Property
    
    var topViewHeight: Constraint?
    var isCompleteLayout: Bool = false
    let disposeBag = DisposeBag()
    
    
    //MARK: - View
    
    private lazy var topView: CalendarTopView = {
        CalendarTopView()
    }()
    
    private lazy var alarmButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.pushViewController(AlarmViewController(), animated: true)}))
        button.setImage(UIImage(named: "alarm"), for: .normal)
        button.tintColor = UIColor(named: "활성화 테두리")
        return button
    }()
    
    private lazy var toolTipView: TooltipView = {
        var toolTipView = TooltipView(text: "읽지 않은 알람 메세지가 3개 있어요!")
        toolTipView.backgroundColor = .white
        return toolTipView
    }()
    
    let scrollView = UIScrollView ()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var monthView: CalendarMonthView = {
         CalendarMonthView()
    }()
    
//    private lazy var calendarCollectionView: UICollectionView = {
//        CalendarView()
//    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        isCompleteLayout = true
        toolTipView.show(animated: false, forView: alarmButton, withinSuperview: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = UIColor(named:"메뉴 배경 1")
    }
    
    override func initView() {
        super.initView()
        [topView, scrollView, alarmButton, toolTipView].forEach {view in self.view.addSubview(view)}
        scrollView.addSubview(contentView)
        [monthView].forEach {view in contentView.addSubview(view)}
        
        
        scrollView.delegate = self
        scrollView.isUserInteractionEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        


    }
    
    override func initConstraint() {
        super.initConstraint()
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            topViewHeight = make.height.equalTo(180).constraint
        }
        
        alarmButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.trailing.equalToSuperview().inset(19)
            make.size.equalTo(24)
        }
        
        toolTipView.snp.makeConstraints { make in
            make.trailing.equalTo(alarmButton.snp.leading).offset(-8)
            make.centerY.equalTo(alarmButton)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(1500)
        }
        
        monthView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(15)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
    }
}

extension MyCalendarViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isCompleteLayout else { return }
        
        if scrollView.contentOffset.y > 0, topView.frame.size.height > 0 {
            updateTopViewHeight(0)
        } else if scrollView.contentOffset.y < 0, topView.frame.size.height == 0 {
            updateTopViewHeight(180)
        }
    }
    
    private func updateTopViewHeight(_ offset: Double) {
        UIView.animate(withDuration: 0.3) {
            self.topViewHeight?.update(offset: offset)
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
}
