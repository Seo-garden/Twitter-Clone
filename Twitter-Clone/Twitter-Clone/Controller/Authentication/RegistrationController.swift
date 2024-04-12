//
//  RegistrationController.swift
//  Twitter-Clone
//
//  Created by 서정원 on 3/22/24.
//
import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class RegistrationController : UIViewController {
    //MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage : UIImage?     //사진이 있을수도 있고, 없을수도 있기 때문에 옵셔널 선언
    
    private let plusPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)       //addTarget() -> 사용자가 직접 컨트롤할 수 있는 객체에 접근하여 특정 이벤트가 발생할 때 마다, 내가 작성한 메서드를 동작할 수 있도록 만들 수 있는 메서드
        return button
    }()
    
    private lazy var emailContainerView : UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")       //#imageLiteral()
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView : UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    private lazy var fullnameContainerView : UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: fullnameTextField)
        return view
    }()
    
    private lazy var usernameContainerView : UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: usernameTextField)
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true     //비밀번호 입력이 안보인다.
        return tf
    }()
    
    private lazy var fullnameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Full name")
        
        return tf
    }()
    
    private lazy var usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        return tf
    }()
    
    private let alreadyHaveAccountButton : UIButton = {
        let button = Utilities().attributeButton("Already have an account? ", "Sign Up")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)     //addTarget() -> 사용자가 직접 컨트롤할 수 있는 객체에 접근하여 특정 이벤트가 발생할 때 마다, 내가 작성한 메서드를 동작할 수 있도록 만들 수 있는 메서드
        return button
    }()
    
    private lazy var registrainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)     //for : 모양
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5       //버튼 4각의 둥근 모양의 정도
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)     //폰트를 굵게
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)     //addTarget() -> 사용자가 직접 컨트롤할 수 있는 객체에 접근하여 특정 이벤트가 발생할 때 마다, 내가 작성한 메서드를 동작할 수 있도록 만들 수 있는 메서드 for: 동작 액션
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selector
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleRegistration() {
        guard let profileImage = profileImage else {
            print("DEBUG : 프로필 사진을 등록하세요")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        //성공했을 때 출력
        AuthService.shared.registerUser(credentials: credentials) { error, ref in
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
            
            guard let tab = UIApplication.shared.keyWindow?.rootViewController as?
                    MainTabController else { return }
            
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView, registrainButton])
        
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually       //축을 따라 정렬된 보기의 크기와 위치를 정의하는 레이아웃인데, 스택뷰의 축을 따라 사용가능한 공간을 채우는 레이아웃
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {        //사진이나 동영상을 선택한 미디어 항복에 엑세스할 수 있음
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        //밑에 2줄 추가하기 전엔 사진이 비율이 낮아지면서 들어갔는데, 오히려 나머지 부분을 자르면서 삽입됐다.
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
