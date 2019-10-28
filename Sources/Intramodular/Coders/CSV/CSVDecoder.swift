//
// Copyright (c) Vatsal Manot
//

import Swift

public final class CSVDecoder {
    public func decode<T: Decodable>(_ type: T.Type, from string: String) throws -> T {
        var rows = string.split(separator: "\n")
        let firstLine = rows.removeFirst()
        let headers = firstLine
            .split(separator: ",")
            .enumerated()
            .map({ CSVHeader(index: $0, key: String($1)) })

        return try T(from: _CSVDecoder(headers: .init(headers), rows: rows.map(String.init)))
    }
}

extension CSVDecoder {
    enum Error: Swift.Error {
        case noHeaders
    }
}

final class _CSVDecoder {
    public var codingPath = [CodingKey]()
    public var userInfo = [CodingUserInfoKey : Any]()

    private let headers: [CSVHeader]
    private let rows: [String]

    required init(headers: [CSVHeader], rows: [String]) {
        self.headers = headers
        self.rows = rows
    }
}

extension _CSVDecoder: Decoder {
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
