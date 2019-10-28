//
// Copyright (c) Vatsal Manot
//

import Swift

#if canImport(AppKit)

import AppKit

public enum AppKitOrUIKitBackgroundFetchResult {
    case newData
    case noData
    case failed
}

#else

import UIKit

public typealias AppKitOrUIKitBackgroundFetchResult = UIBackgroundFetchResult

#endif
