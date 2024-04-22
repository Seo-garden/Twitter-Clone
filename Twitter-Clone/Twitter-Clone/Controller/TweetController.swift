//
//  TweetController.swift
//  Twitter-Clone
//
//  Created by 서정원 on 4/17/24.
//

import UIKit

private let reuseIdentifier = "TweetCell"
private let headerIdentifier = "TweetHeader"

class TweetController : UICollectionViewController {        //collectionview 만든 이유는 트윗에 대한 답글을 표시할 수 있는 기능이 필요했기 때문이다.
    //MARK: - Properties
    
    private let tweet: Tweet
    
    private let actionSheetLauncher : ActionSheetLauncher
        
    private var replies = [Tweet]() {
        didSet{collectionView.reloadData()}
    }
    
    //MARK: - LifeCycle
    init(tweet: Tweet){
        self.tweet = tweet
        self.actionSheetLauncher = ActionSheetLauncher(user: tweet.user)
        super.init(collectionViewLayout: UICollectionViewFlowLayout())      //
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchReplies()
    }
    
    //MARK: - API
    func fetchReplies(){
        TweetService.shared.fetchReplies(forTweet: tweet) { replies in
            self.replies = replies
        }
    }
    //MARK: - Helpers
    
    func configureCollectionView(){
        collectionView.backgroundColor = .white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(TweetHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
}

//MARK: - UICollectionViewDataSource
extension TweetController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return replies.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        
        cell.tweet = replies[indexPath.row]
        
        return cell
    }
}


//MARK: - UICollectionViewDelegate

extension TweetController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! TweetHeader
        header.tweet = tweet        //프로퍼티 트윗을 접근할 수 있다.
        header.delegate = self
        
        return header
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension TweetController: UICollectionViewDelegateFlowLayout { //헤더, 트윗 셀의 크기 정의
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let viewModel = TweetViewModel(tweet: tweet)
        let captionHeight = viewModel.size(forWidth: view.frame.width).height
        
        return CGSize(width: view.frame.width, height: captionHeight + 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

extension TweetController: TweetHeaderDelegate {
    func showActionSheet() {
        actionSheetLauncher.show()
    }
    
    
}
