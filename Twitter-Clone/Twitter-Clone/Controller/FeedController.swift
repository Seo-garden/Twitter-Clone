//
//  FeedController.swift
//  Twitter-Clone
//
//  Created by 서정원 on 3/19/24.
//

import Foundation
import UIKit
import SDWebImage

class FeedController : UIViewController {
    // MARK: - Properties
    var user: User? {
        didSet { configureUILeftBarButton() }
    }
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white     //설정을 따로 하지 않으면 .black 으로 설정
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.setDimensions(width: 44, height: 44)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView        //상단 이미지 삽입
    }
    func configureUILeftBarButton() {
        guard let user = user else { return }
        let profileImageView = UIImageView()
        
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        
        
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}
