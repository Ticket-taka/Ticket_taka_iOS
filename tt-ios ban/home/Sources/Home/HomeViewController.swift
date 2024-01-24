//
//  HomeViewController.swift
//  home
//
//  Created by 오연서 on 1/14/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa


final class HomeViewController: BaseViewController {
    
    // MARK: - Test Data
    
    typealias Project = (projectName: String, projectCardImage: UIImage?)
    
    private var projectList: [Project] = [("프로젝트1", UIImage(named: "card_color1")),
                                          ("프로젝트2", UIImage(named: "card_main")),
                                          ("프로젝트3", UIImage(named: "card_color2"))]
    
    private var imminentTickets: [Ticket] = [Ticket(status: .inProgress,
                                                    color: UIColor(hexCode: "6361FF"),
                                                    name: "ID-1",
                                                    description: "WBS 작성 요청",
                                                    date: "11/10",
                                                    move: true,
                                                    dateColor: .red),
                                             Ticket(status: .toDo,
                                                    color: UIColor(hexCode: "54FFF3"),
                                                    name: "TT-3",
                                                    description: "와이어프레임 수정 요청",
                                                    date: "11/11",
                                                    move: true,
                                                    dateColor: .black)]
    
    // MARK: - Property
    
    var topViewHeight: Constraint?
    var isCompleteLayout: Bool = false
    
    //MARK: - View
    
    private lazy var topView: HomeTopView = {
        HomeTopView()
    }()
    
    private lazy var alarmButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.pushViewController(AlarmViewController(), animated: true)}))
        button.setImage(UIImage(named: "alarm"), for: .normal)
        button.tintColor = UIColor(named: "활성화 테두리")
        return button
    }()
    
    private lazy var toolTipView: TooltipView = {
        var viewController = AlarmViewController()
        var toolTipView = TooltipView(text: "읽지 않은 알람 메세지가 \(viewController.notificationCount())개 있어요!")
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
    
    private lazy var recentProjectView: RecentProjectView = {
        RecentProjectView()
    }()
    
    // 최근 편집한 프로젝트 목록
    lazy var recentProjectCollectionView: UICollectionView = {
        
        let width = (UIScreen.main.bounds.size.width - 20 * 3)/2
        let height = width * 1.17
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.itemSize = .init(width: width, height: height)
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(RecentProjectCollectionViewCell.self)
        return view
    }()
    
    private lazy var imminentTicketView: ImminentTicketView = {
        ImminentTicketView()
    }()
    
    private lazy var graybox: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(named: "Cool gray 4")
            return view
    }()
    
    private lazy var imminentTicketTableViewController: TicketTableViewController = {
        let tableViewController = TicketTableViewController()
        tableViewController.delegate = self
        tableViewController.dataSource = self
        return tableViewController
    }()

    
    
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
        addChild(imminentTicketTableViewController)
    }
    
    override func initView() {
        super.initView()
        [topView, scrollView, alarmButton, toolTipView].forEach {view in self.view.addSubview(view)}
        scrollView.addSubview(contentView)
        [recentProjectView, recentProjectCollectionView, imminentTicketView, imminentTicketTableViewController.view].forEach {view in contentView.addSubview(view)}
        
        
        scrollView.delegate = self
        scrollView.isUserInteractionEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        recentProjectCollectionView.showsHorizontalScrollIndicator = false


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
        
        recentProjectView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalTo(scrollView)
            make.centerX.equalTo(scrollView)
            make.height.equalTo(50)
        }
        
        recentProjectCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recentProjectView.snp.bottom).offset(5)
            make.centerX.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        imminentTicketView.snp.makeConstraints { make in
            make.top.equalTo(recentProjectCollectionView.snp.bottom).offset(15)
            make.leading.trailing.equalTo(scrollView)
            make.centerX.equalTo(scrollView)
            make.height.equalTo(40)
        }
        
        imminentTicketTableViewController.view.snp.makeConstraints { make in
            make.top.equalTo(imminentTicketView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.centerX.equalTo(scrollView)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Int.max
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let project = projectList[indexPath.row % projectList.count]
        return RecentProjectCollectionViewCell.makeCell(
            to: collectionView,
            indexPath: indexPath,
            title: project.projectName,
            cardImage: project.projectCardImage
        )
    }

}


extension HomeViewController: TicketTableViewControllerDelegate,
                              TicketTableViewControllerDataSource {
    func tableViewController(_ tableViewController: TicketTableViewController, numberOfRowsInSection section: Int) -> Int {
        return imminentTickets.count
    }
    
    func tableViewController(_ tableViewController: TicketTableViewController, cellDataForRowAt indexPath: IndexPath) -> Ticket? {
        return imminentTickets[indexPath.row]
    }
}

