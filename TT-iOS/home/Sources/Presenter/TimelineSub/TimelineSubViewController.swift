//
//  TimelineSubViewController.swift
//  home
//
//  Created by 오연서 on 2/6/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TimelineSubViewController: BaseViewController {
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    private var tickets: [Ticket] = Ticket.dummy
    
    private var TT_tickets: [Ticket] = []
    
    // MARK: - View
    
    private lazy var backButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var alarmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "alarm"), for: .normal)
        button.tintColor = UIColor(named: "활성화 테두리")
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타임라인 1"
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 27)
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F6F6F6")
        return view
    }()
    
    private lazy var scrollview = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var timelineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Cool gray 5")
        return view
    }()

    private lazy var createTicketButton: UIButton = {
       let view = UIButton()
        view.setImage(UIImage(named: "createTicket"), for: .normal)
        return view
    }()
    
    private lazy var timelineTicketTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(TimelineTicketTableViewCell.self)
        tableView.sectionHeaderHeight = 2
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        
        createTicketButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(CreateTicketViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = .white
    }
    
    override func initView() {
        super.initView()
        [backButton, alarmButton, titleLabel, dividerView, scrollview, createTicketButton].forEach { view in
            self.view.addSubview(view)
        }
        scrollview.addSubview(contentView)
        contentView.addSubview(timelineView)
        contentView.addSubview(timelineTicketTableView)

    }
    
    override func initConstraint() {
        super.initConstraint()
        
        timelineView.translatesAutoresizingMaskIntoConstraints = false
        timelineTicketTableView.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        alarmButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.trailing.equalToSuperview().inset(19)
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        scrollview.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(2000)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        timelineView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(3)
        }
        
        timelineTicketTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(30)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
        createTicketButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(40)
            make.size.equalTo(60)
        }
        
    }
    
    //프로젝트 확인 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        for ticket in tickets {
            if ticket.code.hasPrefix("TT") {
                TT_tickets.append(ticket)
            }
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension TimelineSubViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TT_tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ticket = TT_tickets[indexPath.row]
        return TimelineTicketTableViewCell.makeCell(to: tableView, indexPath: indexPath, ticket: ticket)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, widthForRowAt: IndexPath) -> CGFloat {
        return 60
    }
}
