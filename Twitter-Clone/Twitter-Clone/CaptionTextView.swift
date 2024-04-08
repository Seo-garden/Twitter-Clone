//
//  CaptionTextView.swift
//  Twitter-Clone
//
//  Created by 서정원 on 4/8/24.
//

import Foundation
import UIKit

class CaptionTextView: UITextView {
    //MARK: Properties
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
