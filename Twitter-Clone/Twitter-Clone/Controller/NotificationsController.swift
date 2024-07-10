//
//  NotificationController.swift
//  Twitter-Clone
//
//  Created by 서정원 on 3/19/24.
//

import Foundation
import UIKit

private let reuseIdentifier = "NotificationCell"

class NotificationsController : UITableViewController {
    // MARK: - Properties
    private var notifications = [Notification]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchNotifications()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
    
    //MARK: - Selectors
    
    @objc func handleRefresh(){
        fetchNotifications()
        
    }
    
    //MARK: - API
    
    //Notifications
    func fetchNotifications(){
        refreshControl?.endRefreshing()
        
        NotificationService.shared.fetchNotifications { [weak self] notifications in
            self?.refreshControl?.endRefreshing()
            self?.notifications = notifications
            self?.checkIfUserIsFollow(notification: notifications)
        }
    }
    
    func checkIfUserIsFollow(notification: [Notification]){
        for (index, notification) in notifications.enumerated() {
            if case .follow = notification.type {
                let user = notification.user
                
                UserService.shared.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
                    self.notifications[index].user.isFollowed = isFollowed
                }
            }
        }
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white     //설정을 따로 하지 않으면 .black 으로 설정
        navigationItem.title = "Notifications"        //상단 이미지 삽입
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
}

//MARK: - UITableViewDataSource

extension NotificationsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        cell.notification = notifications[indexPath.row]
        cell.delegate = self
        return cell
    }
}

//MARK: - UITableViewDelegate
//Notifications 탭에서 클릭했을 때 그 게시물로 이동
extension NotificationsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notification = notifications[indexPath.row]
        
        guard let tweetID = notification.tweetID else { return }
        
        TweetService.shared.fetchTweet(withTweetID: tweetID) { tweet in
            let controller = TweetController(tweet: tweet)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}


//MARK: - NotificationCellDelegate

extension NotificationsController: NotificationCellDelegate {
    func didTapFollow(_ cell: NotificationCell) {
        guard let user = cell.notification?.user else { return }

        
        if user.isFollowed {
            UserService.shared.unfollowUser(uid: user.uid) { err, ref in
                cell.notification?.user.isFollowed = false
            }
        } else {
            UserService.shared.followUser(uid: user.uid) { err, ref in
                cell.notification?.user.isFollowed = true
            }
        }
    }
    
    func didTapProfileImage(_ cell: NotificationCell) {
        guard let user = cell.notification?.user else { return }
        
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}
