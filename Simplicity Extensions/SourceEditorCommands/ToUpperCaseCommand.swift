//
//  SourceEditorCommand.swift
//  Simplicity Extensions
//
//  Created by Josh Angelsberg on 7/20/19.
//  Copyright © 2019 Josh Angelsberg. All rights reserved.
//

import Foundation
import XcodeKit

class ToUpperCaseCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        defer { completionHandler(nil) }
        
        guard let selections = invocation.buffer.selections as? [XCSourceTextRange] else {
            return
        }
        
        for selection in selections {
            invocation.processCaseChange(with: selection, toUpper: true)
        }
    }
}
