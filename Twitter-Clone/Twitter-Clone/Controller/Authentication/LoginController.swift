import Foundation
import UIKit
import FirebaseAuth

class LoginController : UIViewController {
    //MARK: - Properties
    
    private let logoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit        //콘텐츠의 비율을 지켜 View 의 크기에 맞게 확장하는 옵션
        iv.clipsToBounds = true     //넘치는 부분이 있으면 삭제
        iv.image = #imageLiteral(resourceName: "TwitterLogo")           //이미지 삽입    #imageLiteral() 을 입력하면 바뀐다.
        return iv
    }()
    
    private lazy var emailContainerView : UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView : UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)     //for : 모양
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5       //버튼 4각의 둥근 모양의 정도
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)     //폰트를 굵게
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)     //for: 동작 액션
        return button
    }()
    
    private let dontHaveAccountButton : UIButton = {
        let button = Utilities().attributeButton("Don't have an account? ", "Sign Up")
        button.addTarget(self, action: #selector(handleLoginSignUp), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selector
    @objc func handleLoginSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
//    @objc func handleLogin() {
//        guard let email = emailTextField.text else { return }
//        guard let password = passwordTextField.text else { return }
//        
//        AuthService.shared.logUserIn(withEmail: email, password: password) { [weak self] result, error in
//            if let error = error {
//                print("debug: 로그인 에러 \(error.localizedDescription)")
//                return
//            }
//            guard UIApplication.shared.windows.first(where: { $0.isKeyWindow }) != nil else {return}
//            
//            guard let tab = UIApplication.shared.keyWindow?.rootViewController as?
//                    MainTabController else { return }
//            
//            tab.authenticateUserAndConfigureUI()
//            self?.dismiss(animated: true, completion: nil)
//        }
//    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("debug: 로그인 에러 \(error.localizedDescription)")
                return
            }
            
            guard UIApplication.shared.windows.first(where: { $0.isKeyWindow }) != nil else { return }

            guard let tab = UIApplication.shared.keyWindow?.rootViewController as? MainTabController else { return }
            
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
        }
    }

    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true 
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually       //축을 따라 정렬된 보기의 크기와 위치를 정의하는 레이아웃인데, 스택뷰의 축을 따라 사용가능한 공간을 채우는 레이아웃
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, 
                                     right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
}
