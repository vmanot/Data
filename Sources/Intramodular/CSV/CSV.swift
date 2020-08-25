//
// Copyright (c) Vatsal Manot
//

import Compute
import Swallow
import Swift

public struct CSV: AnyProtocol {
    public private(set) var header: [CSVColumnHeader] = []
    
    private var data: [CSVColumnHeader: [String]] = [:]
    
    public init() {
        
    }
    
    public var hasHeaderRow: Bool {
        data.keys.contains(where: { $0.name != nil })
    }
    
    public var numberOfRows: Int {
        data.values.compactMap({ $0.count }).first ?? 0
    }
}

extension CSV {
    public func header(at index: Int) -> CSVColumnHeader {
        header[try: index] ?? CSVColumnHeader(index: index)
    }
    
    public subscript(_ header: CSVColumnHeader) -> [String] {
        get {
            data[header]!
        } set {
            data[header] = newValue
        }
    }
    
    public subscript(_ headerName: String) -> [String] {
        get {
            self[header.first(where: { $0.name == headerName })!]
        } set {
            self[header.first(where: { $0.name == headerName })!] = newValue
        }
    }
    
    public mutating func incrementIndices(by x: Int) {
        data.forEach(mutating: { element in
            element.key.index += x
        })
    }
    
    public mutating func append(_ other: CSV) {
        data.merge(
            other.then({ $0.incrementIndices(by: header.count) }).data,
            uniquingKeysWith: { _, _ in fatalError() }
        )
    }
}

extension CSV {
    @discardableResult
    public mutating func appendColumn(named headerName: String? = nil) -> CSVColumnHeader {
        let columnHeader = CSVColumnHeader(index: header.indices.last.map({ $0 + 1 }) ?? 0, name: headerName)
        
        self.header += columnHeader
        
        data[columnHeader] = Array(repeating: String(), count: numberOfRows)
        
        return columnHeader
    }
}

extension CSV {
    public func filter(_ isIncluded: ([CSVColumnHeader: String]) throws -> Bool) rethrows -> Self {
        var rowIndices = Set<Int>()
        
        let allRowIndices = 0..<numberOfRows
        
        for rowIndex in allRowIndices {
            var row: [CSVColumnHeader: String] = [:]
            
            for columnHeader in header {
                row[columnHeader] = self[columnHeader][rowIndex]
            }
            
            if try isIncluded(row) {
                rowIndices.insert(rowIndex)
            }
        }
        
        return then {
            for header in data.keys {
                $0.data[header]!.remove(at: Set(allRowIndices).subtracting(rowIndices).sorted(by: { $1 > $0 }))
            }
        }
    }
}

// MARK: - Input & Output -

extension CSV {
    public mutating func read(from reader: CSVReader) {
        guard let first = reader.next() else {
            return
        }
        
        if let headerRow = reader.headerRow {
            for (index, name) in headerRow.enumerated() {
                header.append(CSVColumnHeader(index: index, name: name))
            }
        } else {
            for index in first.indices {
                header.append(CSVColumnHeader(index: index))
            }
        }
        
        for row in [first].join(reader.makeSequence()) {
            for (columnIndex, cellValue) in row.enumerated() {
                data[header(at: columnIndex), default: []].append(cellValue)
            }
        }
    }
    
    public mutating func write(to writer: CSVWriter) throws {
        if hasHeaderRow {
            writer.beginNewRow()
            try writer.write(row: header.map({ $0.name ?? "" }))
        }
        
        for rowIndex in 0..<numberOfRows {
            try writer.write(row: header.map({ data[$0]?[rowIndex] ?? "" }))
        }
    }
}
