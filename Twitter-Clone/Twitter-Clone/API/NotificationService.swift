import FirebaseAuth
import UIKit

struct NotificationService {
    static let shared = NotificationService()
    
    func uploadNotification(type: NotificationType, toUser user: User, tweetID: String? = nil) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var values: [String: Any] = ["timestamp": Int(NSDate().timeIntervalSince1970), "uid": uid,
                                     "type": type.rawValue]
        
        if let tweetID = tweetID {
            values["tweetID"] = tweetID
        }
        REF_NOTIFICATIONS.child(user.uid).childByAutoId().updateChildValues(values)
    }
    
    fileprivate func getNotifications(uid: String, completion: @escaping([Notification]) -> Void) {
        var notifications = [Notification]()
        REF_NOTIFICATIONS.child(uid).observe(.childAdded) { snapshot in

            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            
            UserService.shared.fetchUser(uid: uid) { user in
                let notification = Notification(user: user, dictionary: dictionary)
                notifications.append(notification)
                completion(notifications)
            }
        }
    }
    
    func fetchNotifications(completion: @escaping([Notification]) -> Void) {
        let notifications = [Notification]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_NOTIFICATIONS.child(uid).observeSingleEvent(of: .value) { snapshot in
            if !snapshot.exists() {
                //유저가 가진 알림은 없다.
                completion(notifications)
            } else {
                self.getNotifications(uid: uid, completion: completion)
            }
        }
    }
}
