//
//  ProcessCaseChange.swift
//  Simplicity Extensions
//
//  Created by Josh Angelsberg on 7/21/19.
//  Copyright © 2019 Josh Angelsberg. All rights reserved.
//

import Foundation
import XcodeKit

extension XCSourceEditorCommandInvocation {
    
    func processCaseChange(with selection: XCSourceTextRange, toUpper: Bool) -> Void {
        let startLineIndex = selection.start.line
        let startLineCol = selection.start.column
        let endLineIndex = selection.end.line
        let endLineCol = selection.end.column
        let lines = self.buffer.lines
        
        var lineIndex = startLineIndex
        var line = lines[lineIndex] as! NSString
        
        
        if startLineIndex < endLineIndex { // multi line....
            
            // process first line
            var rangeOfContent = NSRange(location: startLineCol, length: line.length - startLineCol)
            var content = line.substring(with: rangeOfContent)
            
            self.buffer.lines[lineIndex] = line.replacingCharacters(in: rangeOfContent, with: Utils.changeCase(of: content, toUpper: toUpper))
            
            // process inner lines
            for i in startLineIndex + 1 ..< endLineIndex {
                lineIndex = i
                line = lines[lineIndex] as! NSString
                self.buffer.lines[lineIndex] = Utils.changeCase(of: line as String, toUpper: toUpper)
            }
            
            // process last line
            lineIndex = endLineIndex
            line = lines[lineIndex] as! NSString
            rangeOfContent = NSRange(location: 0, length: endLineCol)
            content = line.substring(with: rangeOfContent)
            self.buffer.lines[lineIndex] = line.replacingCharacters(in: rangeOfContent, with: Utils.changeCase(of: content, toUpper: toUpper))
            
        } else { // single line
            
            let rangeOfContent = NSRange(location: startLineCol, length: endLineCol - startLineCol)
            let content = line.substring(with: rangeOfContent)
            
            self.buffer.lines[lineIndex] = line.replacingCharacters(in: rangeOfContent, with: Utils.changeCase(of: content, toUpper: toUpper))
        }
    }
    
    func duplicateSelection(for selection: XCSourceTextRange) -> Void {
        
    }
}

class Utils {
    static func changeCase(of text: String, toUpper: Bool) -> String {
        return toUpper ? text.uppercased() : text.lowercased()
    }
}


