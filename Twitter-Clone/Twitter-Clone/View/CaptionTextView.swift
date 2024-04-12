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
        label.text = "무슨 일이 발생하고 있나요?"
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
        //이거 잘 모르겠다. 뭔 기능하더라
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - selectors
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = !text.isEmpty
        
        if text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
}
