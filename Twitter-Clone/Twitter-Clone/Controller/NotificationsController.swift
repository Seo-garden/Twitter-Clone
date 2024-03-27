//
//  NotificationController.swift
//  Twitter-Clone
//
//  Created by 서정원 on 3/19/24.
//

import Foundation
import UIKit
class NotificationsController : UIViewController {
    // MARK: - Properties
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white     //설정을 따로 하지 않으면 .black 으로 설정
        navigationItem.title = "Notification"        //상단 이미지 삽입
        
    }

}
