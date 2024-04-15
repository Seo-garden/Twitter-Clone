//
//  TweetCell.swift
//  Twitter-Clone
//
//  Created by 서정원 on 4/11/24.
//

import UIKit
import Foundation

//본질적으로 컨트롤러로 작업을 위임할 수 있는 방법이다.
protocol TweetCellDelegate: class {     //class protocol 로 만들지 않으면 protocol 을 변수로 사용할 수 없다.
    func handleProfileImageTapped()
    
}

class TweetCell : UICollectionViewCell {
    //MARK: - Properties
    var tweet: Tweet? {
        didSet{ configure() }
    }
    //약한 참조로 하지 않으면 feedController 서로 강한 참조를 갖기 때문에 메모리가 불안정하다.
    weak var delegate: TweetCellDelegate?       //protocol 을 사용하기 위함 델리게이트를 사용하기 위해
    
    private lazy var profileImageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        
        //버튼이 아니라 버튼을 탭하는 이벤트처리를 해야한다.
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true      //상호작용 사실 여부 
        return iv
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0     //이걸 지정하지 않으면 글이 넘어갔을 때 ... 이렇게 찍힌다.
        label.text = "Some test Caption"
        
        return label
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    private let infoLabel = UILabel()
    
    //MARK: - LifeCycle
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addSubview(profileImageview)
        profileImageview.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical      //수직
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: profileImageview.topAnchor, left: profileImageview.rightAnchor,
                     right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.text = "Eddie Brock @ Venom"
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func handleProfileImageTapped(){
        print("debug: Profile image tapped in cell..")
        delegate?.handleProfileImageTapped()
    }
    
    
    @objc func handleCommentTapped(){
        
    }
    
    @objc func handleRetweetTapped(){
        
    }
    
    @objc func handleLikeTapped(){
        
    }
    
    @objc func handleShareTapped(){
        
    }
    
    
    //MARK: - Helpers
    
    func configure(){
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLabel.text = tweet.caption        
        
        profileImageview.sd_setImage(with: viewModel.profileImageUrl)
        infoLabel.attributedText = viewModel.userInfoText
    }
}
