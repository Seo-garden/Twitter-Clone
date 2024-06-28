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
    
    //MARK: - API
    func fetchNotifications(){
        NotificationService.shared.fetchNotifications { notifications in
            self.notifications = notifications
        }
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white     //설정을 따로 하지 않으면 .black 으로 설정
        navigationItem.title = "Notifications"        //상단 이미지 삽입
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    }
}

extension NotificationsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        
        return cell
    }
}
