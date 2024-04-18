//
//  UploadTweetViewModel.swift
//  Twitter-Clone
//
//  Created by 서정원 on 4/18/24.
//

import UIKit

struct UploadTweetViewModel {
    
    let actionButtonTitle: String
    let placeholderText: String
    var shouldShowReplyLabel: Bool
    
    init(config: UploadTweetConfiguration){
        switch config {
        case .tweet:
            <#code#>
        case .reply(_):
            <#code#>
        }
    }
}
