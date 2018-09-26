//
//  ChatViewController.swift
//  SmartChatBot
//
//  Created by Kostis on 21/09/2018.
//  Copyright © 2018 Atcom. All rights reserved.
//

import UIKit
import TLIndexPathTools

class ChatViewController: UIViewController {

    static let nibName = "ChatViewController"
    var dataModel = TLIndexPathDataModel(items: [])
    
    //Outlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var sendButton: UIButton!
    @IBOutlet fileprivate weak var messageField: ChatMessageField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        tableView.register(UINib(nibName: RecieverTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RecieverTableViewCell.identifier)
        tableView.register(UINib(nibName: SenderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SenderTableViewCell.identifier)
        
        dataModel = createDataModel()
        tableView.reloadData()
    }
    
    func createDataModel() -> TLIndexPathDataModel {
        var items: [TLIndexPathItem] = []
        
        let recieverData = MessageModel(senderName: "abby", senderAvatar: nil, senderText: "Feel free to ask me anything ..")
        let recieveritem = TLIndexPathItem(identifier: items.count, sectionName: nil, cellIdentifier: SenderTableViewCell.identifier, data: recieverData)
        
        items = [recieveritem]
        
        return TLIndexPathDataModel(items: items)
    }
    
    func sendMessage(_ message: String) {
        let oldDataModel = dataModel
        
        let messageData = MessageModel(senderName: "me", senderAvatar: nil, senderText: message)
        let messageItem = TLIndexPathItem(identifier: dataModel.items.count, sectionName: nil, cellIdentifier: RecieverTableViewCell.identifier, data: messageData)
        
        var updatedDataModelItems = dataModel.items as! [TLIndexPathItem]
        updatedDataModelItems.append(messageItem)
        dataModel = TLIndexPathDataModel(items: updatedDataModelItems)
        
        let update = TLIndexPathUpdates(oldDataModel: oldDataModel, updatedDataModel: dataModel)
        update.performBatchUpdates(on: tableView, with: .left)
        scrollToBottom(animated: true)
        
        DialogFlowAPI.sendRequest(with: message) { (response) in
            guard let response = response else { return }
            self.addResponseMessage(message: response)
        }
    }
    
    func addResponseMessage(message: String) {
        let oldDataModel = dataModel
        
        let messageData = MessageModel(senderName: "abby", senderAvatar: nil, senderText: message)
        let messageItem = TLIndexPathItem(identifier: dataModel.items.count, sectionName: nil, cellIdentifier: SenderTableViewCell.identifier, data: messageData)
        
        var updatedDataModelItems = dataModel.items as! [TLIndexPathItem]
        updatedDataModelItems.append(messageItem)
        dataModel = TLIndexPathDataModel(items: updatedDataModelItems)
        
        let update = TLIndexPathUpdates(oldDataModel: oldDataModel, updatedDataModel: dataModel)
        update.performBatchUpdates(on: tableView, with: .right)
        scrollToBottom(animated: true)
    }
    
    func scrollToBottom(animated: Bool) {
        let y = tableView.contentSize.height - tableView.frame.size.height + 15
        tableView.setContentOffset(CGPoint(x: 0, y: (y<0) ? 0 : y), animated: animated)
    }
    
    //Outlet Actions
    @IBAction fileprivate func sendPressed(_ sender: UIButton) {
        sendMessage(messageField.text)
        messageField.text = ""
    }
}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let indexPathItem = dataModel.item(at: indexPath) as? TLIndexPathItem, let cellIdentifier = indexPathItem.cellIdentifier, let data = indexPathItem.data as? MessageModel else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        switch cell {
        case let cell as RecieverTableViewCell:
            cell.addMessage(message: data)
            
        case let cell as SenderTableViewCell:
            cell.addMessage(message: data)
            
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.sectionHeaderHeight))
        emptyView.backgroundColor = .clear
        return emptyView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
