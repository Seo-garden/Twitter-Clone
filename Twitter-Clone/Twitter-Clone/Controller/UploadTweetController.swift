//
//  UploadTweetController.swift
//  Twitter-Clone
//
//  Created by 서정원 on 4/6/24.
//
import UIKit
import ActiveLabel

class UploadTweetController: UIViewController {
    
    //MARK: - Property
    private let user : User
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    
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
    
    private lazy var replyLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "replying to @spiderman"
        label.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        label.mentionColor = .twitterBlue
        return label
    }()
    
    private let captionTextView = InputTextView()
    
    //MARK: - LifeCycle
    init(user: User, config: UploadTweetConfiguration) {
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confiqureUI()
        configureMentionHandler()
    }
    
    //MARK: - Selector
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet(){
        guard let caption = captionTextView.text else { return }
        print("debug: 업로드 감지")
        TweetService.shared.uploadTweet(caption: caption, type: config) { error, ref in
            if let error = error {
                print("debug: 트윗하는것을 실패했습니다. \(error.localizedDescription)")
                return
            }
            
            if case .reply(let tweet) = self.config {
                NotificationService.shared.uploadNotification(type: .reply, toUser: tweet.user, tweetID: tweet.tweetID)
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    //MARK: - API
    
    fileprivate func uploadMentionNotification(forCaption caption: String, tweetID: String?) {
        guard caption.contains("@") else { return }
        let words = caption.components(separatedBy: .whitespacesAndNewlines)
        
        words.forEach { word in
            guard word.hasPrefix("@") else { return }
            var username = word.trimmingCharacters(in: .symbols)
            username = username.trimmingCharacters(in: .punctuationCharacters)
            
            UserService.shared.fetchUser(withUsername: username) { mentionedUser in
                NotificationService.shared.uploadNotification(type: .mention, toUser: mentionedUser, tweetID: tweetID)
            }
        }
    }
    
    
    //MARK: - Helpers
    func confiqureUI(){
        view.backgroundColor = .white
        configureNavigationBar()
        
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageview, captionTextView])
        imageCaptionStack.axis = .horizontal
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading      //UploadTweet을 할 때 텍스트길이가 길어서 가려지지 않고 아래로 넘어간다.
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        //stack.alignment = .leading
        stack.spacing = 12
        
        
        view.addSubview(stack)
        
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        profileImageview.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        captionTextView.placeholderLabel.text = viewModel.placeholderText
        
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        guard let replyText = viewModel.replyText else { return }
        replyLabel.text = replyText
    }
    
    
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
    func configureMentionHandler() {
        replyLabel.handleMentionTap { mention in
            print("debug: Mentioned user is \(mention)")
        }
    }
}
