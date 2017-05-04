//
//  AddAppStoreAccount.swift
//  LeafLoading
//
//  Created by jinyulong on 2017/4/14.
//  Copyright © 2017年 云一程. All rights reserved.
//

import Cocoa

@objc protocol AddAppStoreAccountDelegate: class {
    func addAccount(userName: String ,password: String, nickname: String)
}

class AddAppStoreAccount: NSWindowController {
    
    weak var delegate: AddAppStoreAccountDelegate?
    @IBOutlet weak var accountField: NSTextField!
    @IBOutlet weak var secretField: NSTextField!
    @IBOutlet weak var descreptionField: NSTextField!
    override func windowDidLoad() {
        super.windowDidLoad()

    }
    @IBAction func addAccountAction(_ sender: NSButton) {
        let appleID = accountField.stringValue
        let password = secretField.stringValue
        let nickname = descreptionField.stringValue
        if appleID != "" {
            delegate?.addAccount(userName: appleID, password: password, nickname: nickname)
            window?.sheetParent?.endSheet(window!, returnCode: NSModalResponseOK)
        }
        window?.sheetParent?.endSheet(window!, returnCode: NSModalResponseCancel)
    }
    @IBAction func cancelAction(_ sender: NSButton) {
        window?.sheetParent?.endSheet(window!, returnCode: NSModalResponseCancel)
    }
    
    
}
