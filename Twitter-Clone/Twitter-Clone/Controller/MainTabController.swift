//
//  MainTabController.swift
//  Twitter-Clone
//
//  Created by 서정원 on 3/19/24.
//

import UIKit

class MainTabController: UITabBarController {
    // MARK: - Properties
    
    let actionButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white       // 버튼의 글자색
        button.backgroundColor = .twitterBlue  // 버튼의 뒷배경 색
        button.setImage(UIImage(named: "new_tweet"), for: .normal)      //for 은 모양인거 같다.
        button.addTarget(MainTabController.self, action: #selector(actionButtonTapped), for: .touchUpInside)      //self 자기자신을 뜻하고,
        return button
    }()
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func actionButtonTapped(){        //selector 에 사용되기 때문에 @objc 를 붙여야 한다.
        print(123)
    }
    
    
    //MARK: - Helpers
    func configureUI() {
        //extension 파일을 활용하게 되면 상당히 코드가 간결하게 만들 수 있다.
        view.addSubview(actionButton)       //기본 뷰에 추가
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius =  56/2     //
        
        
//        actionButton.translatesAutoresizingMaskIntoConstraints = false      //자동 크기 제약조건을 false 자동 레이아웃활성화
//        actionButton.heightAnchor.constraint(equalToConstant: 56).isActive = true       //크기를 56 X 56 으로 지정.
//        actionButton.widthAnchor.constraint(equalToConstant: 56).isActive = true       //크기를 56 X 56 으로 지정.
//        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true     //isActive = true 를 하지 않으면 크기가 좌측상단에 가게 된다.
//        actionButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true       //isActive = true 를 하지 않으면 크기가 좌측상단에 가게 된다.
//        actionButton.layer.cornerRadius = 56 / 2        //기존의 네모난 모양에서 둥글게 만들어 준다.
    }
    
    func configureViewController() {        //templateNavigationController() 는
        
        
        
        let feed = FeedController()
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: ExploreController())
        
        let notificaions = NotificationsController()
        let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: NotificationsController())
        
        let conversations = ConversationController()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: ConversationController())
        //탭 막대 컨트롤러의 탭을 구성하려면 각 탭의 루트 보기를 제공하는 보기 컨트롤러를 viewControllers 속성에 할당합니다.
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
    
}
