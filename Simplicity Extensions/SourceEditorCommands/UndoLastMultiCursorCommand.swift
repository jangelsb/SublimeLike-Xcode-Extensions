//
//  SourceEditorCommand.swift
//  Simplicity Extensions
//
//  Created by Josh Angelsberg on 7/20/19.
//  Copyright © 2019 Josh Angelsberg. All rights reserved.
//

import Foundation
import XcodeKit

class UndoLastMultiCursorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        defer { completionHandler(nil) }
        
        guard let selections = invocation.buffer.selections as? [XCSourceTextRange], selections.count > 1 else {
            return
        }
        
        invocation.buffer.selections.removeLastObject()
    }
}
