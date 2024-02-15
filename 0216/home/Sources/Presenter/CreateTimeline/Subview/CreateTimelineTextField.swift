//
//  CreateTimelineTextField.swift
//  home
//
//  Created by 오연서 on 2/14/24.
//

import UIKit
import RxSwift
import RxCocoa

extension CreateTimelineViewController {
    final class TextField: BaseView {
        
        // MARK: - Property
        
        var placeHolder: String? {
            didSet { update() }
        }
        
        var textObservable: Observable<String?> {
                return textField.rx.text.asObservable()
            }
        
        // MARK: - View
        
        private lazy var textField: UITextField = {
            let view = UITextField()
            view.borderStyle = .none
            
            return view
        }()
        
        // MARK: - Init
        
        convenience init(_ placeHolder: String) {
            defer {
                self.placeHolder = placeHolder
            }
            
            self.init(frame: .zero)
        }
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
            layer.cornerRadius = 10
            layer.masksToBounds = true
            layer.borderColor = UIColor(named: "기본 테두리")?.cgColor
            layer.borderWidth = 1
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(textField)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            textField.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(18)
            }
        }
        
        // MARK: - Bind
        
        override func update() {
            super.update()
            
            textField.placeholder = placeHolder
        }
    }
}

