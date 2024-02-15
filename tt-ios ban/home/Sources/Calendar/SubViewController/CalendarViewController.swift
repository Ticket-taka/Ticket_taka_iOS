//
//  CalendarViewController.swift
//  home
//
//  Created by 오연서 on 1/23/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa


final class CalendarViewController: UIViewController {
    
    
    var collectionView: UICollectionView!
    
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks: [String] = ["SUN", "MON", "TUE", "WED", "THUR", "FRI", "SAT"]
    var days: [String] = []
    var daysCountInMonth = 0
    var weekdayAdding = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.initView()
    }
    
//    private func initView() {
//        self.initCollection()
//        components.month = cal.component(.month, from: now)
//        components.day = 1
//        self.calculation()
//    }
//    
    private func initCollection() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
        //self.collectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:))))
    }
    
    private func calculation() {
        let firstDayOfMonth = cal.date(from: components)
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday
        
        
        self.days.removeAll()
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 {
                self.days.append("")
            } else {
                self.days.append(String(day))
            }
        }
    }
    
    @IBAction func didTappedPrevButton(_ sender: UIButton) {
        components.month = components.month! - 1
        self.calculation()
        self.collectionView.reloadData()
    }
    
    @IBAction func didTappedNextButton(_ sender: UIButton) {
        components.month = components.month! + 1
        self.calculation()
        self.collectionView.reloadData()
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return self.days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCollectionViewCell
        
        switch indexPath.section {
        case 0:
            cell.dateLabel.text = weeks[indexPath.row]
        default:
            cell.dateLabel.text = days[indexPath.row]
        }
        
        if indexPath.row % 7 == 0 {
            cell.dateLabel.textColor = .red
        } else if indexPath.row % 7 == 6 {
            cell.dateLabel.textColor = .blue
        } else {
            cell.dateLabel.textColor = .black
        }
        
        return cell
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let myBoundSize: CGFloat = UIScreen.main.bounds.size.width
        let cellSize : CGFloat = myBoundSize / 9
        return CGSize(width: cellSize, height: cellSize)
    }
}
