//
//  InputViewController.swift
//  LeafLoading
//
//  Created by jinyulong on 2017/4/14.
//  Copyright © 2017年 云一程. All rights reserved.
//

import Cocoa

@objc protocol InputViewControllerDelegate: class {
    func didAddActivityCode(code: String)
}

class InputViewController: NSWindowController {
    
    weak var delegate: InputViewControllerDelegate?
    @IBOutlet weak var textField: NSTextField!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        textField.stringValue = ""
    }
    
    @IBAction func addAccount(_ sender: NSButton) {
        let activityCode = textField.stringValue
        if activityCode != "" {
            delegate?.didAddActivityCode(code: activityCode)
            window?.sheetParent?.endSheet(window!, returnCode: NSModalResponseOK)
        }
    }
    
    @IBAction func cancel(_ sender: NSButton) {
        window?.sheetParent?.endSheet(window!, returnCode: NSModalResponseCancel)
    }
}
