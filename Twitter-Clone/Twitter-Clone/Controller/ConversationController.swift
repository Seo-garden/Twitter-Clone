import Foundation
import UIKit

class ConversationController : UIViewController {
    // MARK: - Properties
    
    
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white     //설정을 따로 하지 않으면 .black 으로 설정
        navigationItem.title = "Messages"
    }

}
