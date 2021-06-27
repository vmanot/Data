//
// Copyright (c) Vatsal Manot
//

import Combine
import Swift

public final class CSVDecoder: TopLevelDecoder {
    enum Error: Swift.Error {
        case noHeaders
    }
    
    final class _Decoder: Decoder {
        public var codingPath = [CodingKey]()
        public var userInfo = [CodingUserInfoKey : Any]()
        
        private let headers: [CSVColumnHeader]
        private let rows: [String]
        
        required init(headers: [CSVColumnHeader], rows: [String]) {
            self.headers = headers
            self.rows = rows
        }
        
        func container<Key: CodingKey>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key>  {
            let row = rows.first ?? ""
            
            return KeyedDecodingContainer(KeyedContainer<Key>(headers: headers, row: row, codingPath: codingPath))
        }
        
        func unkeyedContainer() throws -> UnkeyedDecodingContainer {
            let container = UnkeyedContainer(headers: self.headers, rows: self.rows, codingPath: self.codingPath)
            return container
        }
        
        func singleValueContainer() throws -> SingleValueDecodingContainer {
            return SingleValueContainer(headers: self.headers, rows: self.rows, codingPath: self.codingPath)
        }
    }
    
    public init() {
        
    }
    
    public func decode<T: Decodable>(_ type: T.Type, from string: String) throws -> T {
        var rows = string.contains("\r\n")
        ? string.split(separator: "\r\n")
        : string.split(separator: "\n")
        
        let headers = rows
            .removeFirst()
            .split(separator: ",")
            .enumerated()
            .map({ CSVColumnHeader(index: $0, name: String($1)) })
        
        return try T(from: _Decoder(headers: .init(headers), rows: rows.map(String.init)))
    }
}
