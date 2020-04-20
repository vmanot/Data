//
// Copyright (c) Vatsal Manot
//

import Compute
import Swallow

public struct CSV: AnyProtocol {
    private var data: [CSVHeader: [Int: String]] = [:]
    
    public init() {
        
    }
    
    public var hasHeaderRow: Bool {
        data.keys.contains(where: { $0.name != nil })
    }
    
    public var headers: [CSVHeader] {
        data.keys.sorted()
    }
    
    public var maxIndex: Int? {
        headers.last?.index
    }
    
    public var numberOfRows: Int {
        (data.values.compactMap({ $0.keys.max() }).first ?? 0) + 1
    }
}

extension CSV {
    public func header(at index: Int) -> CSVHeader {
        data.keys.first(where: { $0.index == index }) ?? CSVHeader(index: index)
    }
    
    public subscript(_ headerName: String) -> [Int: String]? {
        get {
            data[headers.first(where: { $0.name == headerName })]
        } set {
            data[headers.first(where: { $0.name == headerName })] = newValue
        }
    }
    
    public mutating func incrementIndices(by x: Int?) {
        guard let x = x else {
            return
        }
        
        data.forEach(mutating: { element in
            element.key.incrementIndex(by: x)
        })
    }
    
    public mutating func append(_ other: CSV) {
        data.merge(
            other.then({ $0.incrementIndices(by: maxIndex) }).data,
            uniquingKeysWith: { _, _ in fatalError() }
        )
    }
}

extension CSV {
    public mutating func read(from reader: CSVReader) {
        guard let first = reader.next() else {
            return
        }
        
        var indexedHeaders: [Int: CSVHeader] = [:]
        
        if let headerRow = reader.headerRow {
            for (index, name) in headerRow.enumerated() {
                let header = CSVHeader(index: index, name: name)
                indexedHeaders[index] = header
            }
        } else {
            for index in first.indices {
                indexedHeaders[index] = CSVHeader(index: 1)
            }
        }
        
        for (rowIndex, row) in [first].join(reader.makeSequence()).enumerated() {
            for (columnIndex, cellValue) in row.enumerated() {
                data[header(at: columnIndex), default: [:]][rowIndex] = cellValue
            }
        }
    }
    
    public mutating func write(to writer: CSVWriter) throws {
        if hasHeaderRow {
            writer.beginNewRow()
            try writer.write(row: headers.map({ $0.name ?? "" }))
        }
        
        for rowIndex in 0..<numberOfRows {
            try writer.write(row: headers.map({ data[$0]?[rowIndex] ?? "" }))
        }
    }
}
