//
//  FeedController.swift
//  Twitter-Clone
//
//  Created by 서정원 on 3/19/24.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "TweetCell"

class FeedController : UICollectionViewController {
    // MARK: - Properties
    var user: User? {
        didSet { configureUILeftBarButton() }
    }
    
    //MARK: - API
    func fetchTweets(){
        TweetService.shared.fetchTweets { tweets in
            print("debug: Tweets are \(tweets)")
        }
    }
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white     //설정을 따로 하지 않으면 .black 으로 설정
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        
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

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5        //5개의 셀을 돌려줄 것
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {      //grid 기반의 layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
