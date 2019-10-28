//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow
import Swift

public protocol CodableUnit: opaque_Hashable, Codable {
    func hash(into: inout Hasher)
}

// MARK: - Concrete Implementations -

extension Bool: CodableUnit {

}

extension Double: CodableUnit {

}

extension Float: CodableUnit {

}

extension Int: CodableUnit {

}

extension Int8: CodableUnit {

}

extension Int16: CodableUnit {

}

extension Int32: CodableUnit {

}

extension Int64: CodableUnit {

}

extension UInt: CodableUnit {

}

extension UInt8: CodableUnit {

}

extension UInt16: CodableUnit {

}

extension UInt32: CodableUnit {

}

extension UInt64: CodableUnit {

}

extension String: CodableUnit {

}
