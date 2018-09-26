//
//  SenderTableViewCell.swift
//  TVChat
//
//  Created by Kostis on 11/09/2018.
//  Copyright © 2018 Atcom. All rights reserved.
//

import UIKit

class SenderTableViewCell: UITableViewCell {

    static let identifier = "SenderTableViewCell"
    
    //Outlets
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bubbleImageView.layer.cornerRadius = bubbleImageView.frame.height/2
    }

    func addMessage(message: MessageModel) {
        messageLabel.text = message.senderText ?? ""
    }
}
