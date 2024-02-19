//
//  NewTeamViewController.swift
//  home
//
//  Created by 반성준 on 2024/01/16.
//

import UIKit

import RxSwift
import RxCocoa

final class NewTeamViewController: BaseViewController {
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    private var addedTeamIconImage: UIImage? = nil
    private var doneAdded = false
    
    private var defaultImageSelected = false
    private var customImageSelected = false

    
    // MARK: - View
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        UIScrollView()
    }()
    
    private lazy var containerView: UIView = {
        UIView()
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 팀을\n만들어 보세요."
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 27)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "팀 이름"
        label.textColor = UIColor(named: "서브 텍스트 1")
        
        return label
    }()
    
    private lazy var teamNameTextField: TextField = {
        let view = TextField()
        view.placeHolder = "팀 이름"
        
        return view
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "초대할 팀원"
        label.textColor = UIColor(named: "서브 텍스트 1")
        
        return label
    }()
    
    private lazy var userNameTextFieldStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 11
        return view
    }()
    
    private lazy var newTeamButton: NewTeamButtonView = {
        NewTeamButtonView()
    }()
    
    private lazy var teamIconStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 11
        return view
    }()
    
    private lazy var teamIconView: TeamIconView = {
        TeamIconView()
    }()
    
    private lazy var completeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Primary color")
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    private lazy var imagePicker: UIImagePickerController = {
        let vc = UIImagePickerController()
        //vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        return vc
    }()
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = .white
    }
    
    override func initView() {
        super.initView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(backButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(teamNameLabel)
        containerView.addSubview(teamNameTextField)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(userNameTextFieldStackView)
        containerView.addSubview(newTeamButton)
        containerView.addSubview(teamIconView)
        
        view.addSubview(completeButton)
        
        userNameTextFieldStackView.addArrangedSubview(TextField("아이디"))
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(completeButton.snp.top).offset(-16)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView.contentLayoutGuide)
            make.leading.trailing.equalTo(self.view)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        teamNameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(27)
        }
        
        teamNameTextField.snp.makeConstraints { make in
            make.top.equalTo(teamNameLabel.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(teamNameTextField.snp.bottom).offset(44)
            make.leading.trailing.equalToSuperview().inset(27)
        }
        
        userNameTextFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        newTeamButton.snp.makeConstraints { make in
            make.top.equalTo(userNameTextFieldStackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        teamIconView.snp.makeConstraints { make in
            make.top.equalTo(newTeamButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(56)
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        
        newTeamButton.rx.controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.userNameTextFieldStackView.addArrangedSubview(TextField("아이디"))
            }
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        teamIconView.defaultIconView.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                    owner.checkdefaultView()
            }
            .disposed(by: disposeBag)
    
        teamIconView.addPhotoView.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                if !self.doneAdded {
                    owner.showAddTeamIconActionSheet()
                }
                else {
                    owner.checkIconView()
                }
            }
            .disposed(by: disposeBag)
        
        completeButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                    owner.completeButtonTapped()
            }
            .disposed(by: disposeBag)
    }
}

extension NewTeamViewController {
    
    func didTabselectButtuon(){
        let vc = UIImagePickerController()
        //vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    func showAddTeamIconActionSheet() {
        let actionSheetController = UIAlertController()
        let actionCamera = UIAlertAction(title: "카메라",
                                         style: .default,
                                         handler: openCameraAction)
        let actionGallery = UIAlertAction(title: "사진 앨범",
                                          style: .default,
                                          handler: openGalleryAction)
        let actionCancel = UIAlertAction(title: "취소", style: .cancel)
        
        actionSheetController.addAction(actionCamera)
        actionSheetController.addAction(actionGallery)
        actionSheetController.addAction(actionCancel)
        
        self.present(actionSheetController, animated: true)
    }
    
    func checkdefaultView() {
        defaultImageSelected = true
        customImageSelected = false
        teamIconView.defaultIconView.iconContainerView.layer.borderColor = UIColor(named: "경고")?.cgColor
        teamIconView.addPhotoView.iconContainerView.layer.borderColor = UIColor(named: "서브 텍스트 1")?.cgColor
    }
    
    func checkIconView() {
        defaultImageSelected = true
        customImageSelected = false
        teamIconView.defaultIconView.iconContainerView.layer.borderColor = UIColor(named: "서브 텍스트 1")?.cgColor
        teamIconView.addPhotoView.iconContainerView.layer.borderColor = UIColor(named: "경고")?.cgColor
    }
    
    func openCameraAction(_ action: UIAlertAction) { 
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            didTabselectButtuon()
                self.imagePicker.sourceType = .camera
                self.imagePicker.modalPresentationStyle = .currentContext
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                print("카메라에 접근할 수 없습니다.")
            }
    }
    
    func openGalleryAction(_ action: UIAlertAction) { 
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
                didTabselectButtuon()
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.modalPresentationStyle = .currentContext
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                print("앨범에 접근할 수 없습니다.")
            }
    }
    
    func completeButtonTapped() {
        guard let teamName = teamNameTextField.placeHolder else {
            return
        }
        var teamImage: UIImage?
        if defaultImageSelected {
            teamImage = teamIconView.defaultIconView.imageName
        } else if customImageSelected {
            teamImage = teamIconView.addPhotoView.imageName
        } else {
            return
        }
        
//        TeamViewController.stringArr.insert(teamName, at: 0)
//        
//        TeamViewController.layoutView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
    }
}

extension NewTeamViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            teamIconView.addPhotoView.addIconView.isHidden = false
            teamIconView.addPhotoView.iconView.isHidden = true
            teamIconView.addPhotoView.addIconView.image = image
            teamIconView.addPhotoView.text = "커스텀1"
            self.doneAdded = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
