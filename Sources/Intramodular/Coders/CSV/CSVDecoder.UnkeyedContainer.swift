//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow
import Swift

extension _CSVDecoder {
    final class UnkeyedContainer {
        var currentIndex = 0
        let codingPath: [CodingKey]
        
        private let headers: [CSVHeader]
        private let rows: [String]

        required init(headers: [CSVHeader], rows: [String], codingPath: [CodingKey])  {
            self.headers = headers
            self.rows = rows
            self.codingPath = codingPath
        }
    }
}

extension _CSVDecoder.UnkeyedContainer: UnkeyedDecodingContainer {
    var count: Int? {
        return self.rows.count
    }
    
    var isAtEnd: Bool {
        return self.currentIndex >= (self.count ?? 0)
    }
    
    func decodeNil() throws -> Bool {
        return !self.isAtEnd
    }
    
    func decode<T: Decodable>(_ type: T.Type) throws -> T  {
        guard !self.isAtEnd else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "no more values")
        }
        
        defer {
            self.currentIndex += 1
        }
        
        let row = self.rows[self.currentIndex]
        let decoder = _CSVDecoder(headers: self.headers, rows: [row])
        
        return try T(from: decoder)
    }
    
    func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer  {
        unimplemented()
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        unimplemented()
    }
    
    func superDecoder() throws -> Decoder {
        unimplemented()
    }
}
