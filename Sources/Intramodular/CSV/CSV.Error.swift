//
// Copyright (c) Vatsal Manot
//

import Swift

extension CSV {
    /// No overview available.
    public enum Error: Swift.Error {
        /// No overview available.
        case cannotOpenFile
        /// No overview available.
        case cannotReadFile
        /// No overview available.
        case cannotWriteStream
        /// No overview available.
        case streamErrorHasOccurred(error: Swift.Error)
        /// No overview available.
        case unicodeDecoding
        /// No overview available.
        case cannotReadHeaderRow
        /// No overview available.
        case stringEncodingMismatch
        /// No overview available.
        case stringEndianMismatch
    }
}
