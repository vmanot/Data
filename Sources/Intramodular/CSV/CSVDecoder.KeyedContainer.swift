//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow

extension CSVDecoder._Decoder {
    final class KeyedContainer<Key: CodingKey>  {
        let codingPath: [CodingKey]
        
        private let headers: [CSVColumnHeader]
        private let values: [String]
        
        required init(headers: [CSVColumnHeader], row: String, codingPath: [CodingKey]) {
            self.headers = headers
            self.codingPath = codingPath
            self.values = row.split(separator: ",").map({ (substring) -> String in
                return String(substring)
            })
        }
    }
}

extension CSVDecoder._Decoder.KeyedContainer: KeyedDecodingContainerProtocol {
    var allKeys: [Key] {
        return self.headers.compactMap({ (header) -> Key? in
            return Key(stringValue: header.name ?? String(header.index))
        })
    }
    
    func contains(_ key: Key) -> Bool {
        let header = self.headers.first { (header) -> Bool in
            return header.name == key.stringValue
        }
        
        guard let unwrappedHeader = header,
            unwrappedHeader.index < self.values.count,
            !self.values[unwrappedHeader.index].isEmpty else {
                return false
        }
        
        return true
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        return !self.contains(key)
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String  {
        let header = headers.first { $0.name == key.stringValue }
        
        guard let unwrappedHeader = header else  {
            let context = DecodingError.Context(codingPath: self.codingPath, debugDescription: "Values: \(self.values) Headers: \(self.headers)")
            throw DecodingError.keyNotFound(key, context)
        }
        
        return self.values[unwrappedHeader.index]
    }
    
    func decode<T: LosslessStringConvertible>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        let string = try self.decode(String.self, forKey: key)
        
        guard let value = T(string) else  {
            let context = DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Components: \(self.values) Headers: \(self.headers)"
            )
            
            throw DecodingError.typeMismatch(type, context)
        }
        
        return value
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable  {
        let row = self.values.joined()
        let decoder = CSVDecoder._Decoder(headers: self.headers, rows: [row])
        let value = try T(from: decoder)
        
        return value
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        TODO.unimplemented
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        TODO.unimplemented
    }
    
    func superDecoder() throws -> Decoder  {
        TODO.unimplemented
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        TODO.unimplemented
    }
}
