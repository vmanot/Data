//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow

class UnicodeIterator<Input: IteratorProtocol, InputEncoding: UnicodeCodec>: IteratorProtocol where InputEncoding.CodeUnit == Input.Element {
    private var input: Input
    private var inputEncoding: InputEncoding
    
    var errorHandler: ((Error) -> Void)?
    
    internal init(input: Input, inputEncodingType: InputEncoding.Type) {
        self.input = input
        self.inputEncoding = inputEncodingType.init()
    }
    
    func next() -> UnicodeScalar? {
        switch inputEncoding.decode(&input) {
            case .scalarValue(let c):
                return c
            case .emptyInput:
                return nil
            case .error:
                errorHandler?(CSV.Error.unicodeDecoding)
                return nil
        }
    }
    
}
