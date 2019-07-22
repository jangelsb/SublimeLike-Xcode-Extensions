//
//  SourceEditorCommand.swift
//  Simplicity Extensions
//
//  Created by jangelsb on 7/20/19.
//  Copyright © 2019 jangelsb. All rights reserved.
//

import Foundation
import XcodeKit

class DuplicateSelectionsCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        defer { completionHandler(nil) }
        
        guard let selections = invocation.buffer.selections as? [XCSourceTextRange] else {
            return
        }
        
        for selection in selections {
            invocation.duplicateSelection(for: selection)
        }
    }
}
