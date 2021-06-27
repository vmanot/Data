//
// Copyright (c) Vatsal Manot
//

import FoundationX
import Swallow
import SwiftUIX
import SwiftUI

extension JSON {
    public struct Children {
        public struct Element: Hashable {
            public let label: AnyCodingKey?
            public let value: JSON
            
            public init(label: AnyCodingKey?, value: JSON) {
                self.label = label
                self.value = value
            }
            
            public var children: [Element]? {
                value.children
            }
        }
        
        public struct Index: Hashable {
            public let index: Int
            public let key: String?
        }
        
        private let base: JSON
        
        public var indices: AnyRandomAccessCollection<Index> {
            switch base {
                case .null:
                    return .init([])
                case .bool:
                    return .init([])
                case .date:
                    return .init([])
                case .number:
                    return .init([])
                case .string:
                    return .init([])
                case .array(let value):
                    return .init(value.indices.map({ Index(index: $0, key: nil) }))
                case .dictionary(let value):
                    return .init(value.keys.enumerated().map({ Index(index: $0.0, key: $0.1) }))
            }
        }
    }
    
    public var children: [Children.Element]? {
        if case .array(let value) = self {
            return value
                .enumerated()
                .map({ .init(label: AnyCodingKey(intValue: $0.0), value: $0.1) })
        } else if case .dictionary(let value) = self {
            return value.map({ .init(label: AnyCodingKey(stringValue: $0.0), value: $0.1) })
        } else {
            return nil
        }
    }
}

struct JSONView<Label: View>: View {
    @Binding var json: JSON
    
    let label: Label
    
    public init(json: Binding<JSON>, @ViewBuilder label: () -> Label) {
        self._json = json
        self.label = label()
    }
    
    public var body: some View {
        switch json {
            case .null:
                Text("null").italic()
            case .bool(let value):
                Toggle(isOn: Binding<Bool>(get: { value }, set: { json = .bool($0) })) {
                    label
                }
            case .date(let value):
                Text(value.dd_dot_MM_dot_YYYY)
            case .number(let value):
                Text(value.description)
            case .string(let value):
                Text(value)
            case .array(let value):
                OutlineGroup(
                    value.enumerated().map({ JSON.Children.Element(label: AnyCodingKey(intValue: $0.0), value: $0.1) }),
                    id: \.self,
                    children: \.children
                ) { element in
                    if let label = element.label {
                        Text(label.description)
                    }
                }
            case .dictionary(let value):
                ForEach(value.sorted(by: { $0.key < $1.key }), id: \.key) { (key, value) in
                    JSONView<Text>(
                        json: .init(
                            get: { value },
                            set: { _ in }
                        )
                    ) {
                        Text(key)
                    }
                }
        }
    }
}

extension JSON {
    struct ArrayView: View {
        let value: Binding<[JSON]>
        
        var body: some View {
            EmptyView()
        }
    }
}
