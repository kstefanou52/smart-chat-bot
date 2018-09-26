//
//  ChatMessageField.swift
//  SmartChatBot
//
//  Created by Kostis on 21/09/2018.
//  Copyright © 2018 Atcom. All rights reserved.
//

import UIKit

class ChatMessageField: UITextView {
    
    let placeHolder = "write here .."
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        self.delegate = self
        layer.cornerRadius = 8
        setupPlaceHolder()
    }
    
    fileprivate func setupPlaceHolder() {
        self.textColor = UIColor.lightGray
        self.text = placeHolder
    }
    
    fileprivate func setupText(with text: String) {
        self.textColor = UIColor.black
        self.text = text
    }
}
extension ChatMessageField: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty { setupPlaceHolder() ; return }
        if textView.text.contains(placeHolder) { setupText(with: "\(textView.text.last ?? Character.init(""))") ; return }
        if textView.text != placeHolder { setupText(with: textView.text) ; return }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == placeHolder { return false }
        return true
    }
}
