import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage



struct AuthCredentials {
    let email : String
    let password : String
    let fullname: String
    let username : String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        print("debug: 이메일은 \(email), 암호는 \(password)")
    }
    

    //Firebase 작업이 비동기적으로 수행되기 때문에, 클로저가 함수를 벗어난 후에 실행되어야 하므로 @escaping 이 필요하다.
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let username = credentials.username
        let fullname = credentials.fullname
        let profileImage = credentials.profileImage
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString      //객체, 세션, 엔티티를 고유하게 식별하는데 사용한다.
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata:nil) { meta, error in        //프로필사진 데이터 삽입
            storageRef.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("debug : 에러 \(error.localizedDescription)")
                        return      //return 을 넣지 않으면 항목이 실행되고 앱이 중단될 수 있다.
                    }
                    //firebase database 등록
                    guard let uid = result?.user.uid else { return }
                    
                    let values = ["email" : email,
                                  "username" : username,
                                  "fullname": fullname,
                                  "profileImageUrl": profileImageUrl]
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
