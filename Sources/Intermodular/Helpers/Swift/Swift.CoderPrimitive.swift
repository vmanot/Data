//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow
import Swift

public protocol CoderPrimitive: opaque_Hashable, Codable {
    func hash(into: inout Hasher)
}

// MARK: - Concrete Implementations -

extension Bool: CoderPrimitive {

}

extension Double: CoderPrimitive {

}

extension Float: CoderPrimitive {

}

extension Int: CoderPrimitive {

}

extension Int8: CoderPrimitive {

}

extension Int16: CoderPrimitive {

}

extension Int32: CoderPrimitive {

}

extension Int64: CoderPrimitive {

}

extension UInt: CoderPrimitive {

}

extension UInt8: CoderPrimitive {

}

extension UInt16: CoderPrimitive {

}

extension UInt32: CoderPrimitive {

}

extension UInt64: CoderPrimitive {

}

extension String: CoderPrimitive {

}
