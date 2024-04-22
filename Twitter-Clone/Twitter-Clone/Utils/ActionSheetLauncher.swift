//
//  ActionSheetLauncher.swift
//  Twitter-Clone
//
//  Created by 서정원 on 4/22/24.
//

import Foundation

class ActionSheetLauncher: NSObject {       //
    //MARK: Properties
    
    private let user: User
    
    init(user: User){
        self.user = user
        super.init()
    }
    
    //MARK: - Helpers
    
    func show(){
        print("debug: Show action sheet for user \(user.username)")
    }
}
