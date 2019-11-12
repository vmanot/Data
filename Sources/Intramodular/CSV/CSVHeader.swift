//
// Copyright (c) Vatsal Manot
//

import Swift

struct CSVHeader: Codable, Hashable {
    let index: Int
    let key: String

    init(index: Int, key: String) {
        self.index = index
        self.key = key
    }
}
