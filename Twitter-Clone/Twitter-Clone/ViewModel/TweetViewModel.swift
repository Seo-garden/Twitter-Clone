//
//  TweeetViewModel.swift
//  Twitter-Clone
//
//  Created by 서정원 on 4/12/24.
//

import Foundation
import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user: User
    
    var profileImageUrl: URL? {
        return tweet.user.profileImageUrl
    }
    
    var timeStamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]      //나타내는 시간의 속성
        formatter.unitsStyle = .abbreviated             //
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now)!
    }
    //닉네임을 얻기 위한 과정
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        title.append(NSAttributedString(string: " ． \(timeStamp)", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    init(tweet: Tweet){
        self.tweet = tweet
        self.user = tweet.user
    }
}
