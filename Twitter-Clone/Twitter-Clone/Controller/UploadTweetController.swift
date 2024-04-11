//
//  UploadTweetController.swift
//  Twitter-Clone
//
//  Created by 서정원 on 4/6/24.
//

import Foundation
import UIKit

class UploadTweetController: UIViewController {
    //MARK: - Property
    override var preferredStatusBarStyle: UIStatusBarStyle {        //이거 왜 안되노
        return .lightContent // 또는 .default
    }

    private let user : User

    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        
        return button
    }()
    
    private let profileImageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        
        return iv
    }()
    
    private let captionTextView = CaptionTextView()
    
    

    //MARK: - LifeCycle
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confiqureUI()
        
        print("debug: User is \(user.username)")
    }
    
    //MARK: - Selector
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet(){
        
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: caption) { error, ref in
            if let error = error {
                print("debug: 트윗하는것을 실패했습니다. \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    //MARK: - API
    
    
    
    
    
    //MARK: - Helpers
    func confiqureUI(){
        view.backgroundColor = .white
        configureNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [profileImageview, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        profileImageview.sd_setImage(with: user.profileImageUrl, completed: nil)
    }

    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
}
