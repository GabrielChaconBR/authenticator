//
//  FormatterTextFieldUtil.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 30/03/24.
//

import Foundation

public protocol Mask {
    var maskFormat: String { get set }
    func formateValue(_ value: String) -> String
}

extension Mask {
    public func formateValue(_ value: String) -> String {
        let cleanNumber = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = maskFormat
        var result = String()
        var index = cleanNumber.startIndex
        for ch in mask where index < cleanNumber.endIndex {
            if ch == "#" {
                result.append(cleanNumber[index])
                index = cleanNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

struct DataMask: Mask {
    var maskFormat: String
}
