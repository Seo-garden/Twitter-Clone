//
//  UserService.swift
//  Twitter-Clone
//
//  Created by 서정원 on 4/5/24.
//

import Foundation
import FirebaseAuth

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void){
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        print("debug: 현재 아이디는 \(uid)")  uid 를 가져오는걸 확인할 수 있다.
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            //print("debug: snapshot is \(snapshot)")        //snapshot 이 전부 돌려 받는다
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }   //저장되는 데이터 타입이 딕셔너리 타입이다.
            let user = User(uid: uid, dictionary: dictionary)
            
            completion(user)
        }
    }
}
