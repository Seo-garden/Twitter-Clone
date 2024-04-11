//
//  TweetService.swift
//  Twitter-Clone
//
//  Created by 서정원 on 4/10/24.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct TweetService {
    static let shared = TweetService()
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweet": 0, "caption": caption ] as [String : Any]
        //Constrants 에 있는 변수사용
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        
        
        REF_TWEETS.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            let tweetID = snapshot.key
            let tweet = Tweet(tweetID:tweetID , dictionary: dictionary)
            
            tweets.append(tweet)
            completion(tweets)
        }
    }
}
