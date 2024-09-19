

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
    let uid: String
    var likes: Int
    var timestamp: Date!
    let retweetCount: Int
    var user: User
    var didLike = false
    var replyingTo: String?
    
    var isReply: Bool { return replyingTo != nil }
    
    init(user: User, tweetID: String, dictionary: [String: Any]) {
        self.tweetID = tweetID
        
        
        
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["caption"] as? Int ?? 0
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        self.user = user
        
        if let replyingTo = dictionary["replyingTo"] as? String {
            self.replyingTo = replyingTo
        }
    }
}
