//
// Copyright (c) Vatsal Manot
//

import Swallow
import Swift

func attemptContainerAgnosticDecodeRecovery<T: Decodable>(type: T.Type, error: Error) -> T? {
    if case DecodingError.keyNotFound(let key, _) = error {
        if let type = T.self as? opaque_Optional.Type, let wrapped = type.opaque_Optional_Wrapped as? KeyConditionalNilDecodable.Type {
            if wrapped.mandatoryCodingKeys.contains(where: { $0.stringValue == key.stringValue }) {
                return try? cast(type.init(none: ()))
            }
        }
    }
    
    return nil
}

func attemptDecodeRecovery<Container: KeyedDecodingContainerProtocol, T: Decodable>(container: Container, type: T.Type, key: Container.Key, error: Error) -> T? {
    return nil
}

func attemptDecodeIfPresentRecovery<Container: KeyedDecodingContainerProtocol, T: Decodable>(container: Container, type: T.Type, key: Container.Key, error: Error) -> T?? {
    do {
        return try container.decode(JSON.Empty.self, forKey: key).proof()
    } catch {
        
    }
    
    return nil
}

func attemptDecodeIfPresentRecovery<Container: SingleValueDecodingContainer, T: Decodable>(container: Container, type: T.Type, error: Error) -> T?? {
    do {
        return try container.decode(JSON.Empty.self).proof()
    } catch {
        
    }
    
    return nil
}

func attemptDecodeIfPresentRecovery<Container: UnkeyedDecodingContainer, T: Decodable>(container: Container, type: T.Type, error: Error) -> T?? {
    return nil
}

extension SingleValueDecodingContainer {
    func decodeIfPresentWithRecovery<T: Decodable>(_ type: T.Type) throws -> T? {
        guard !decodeNil() else {
            return nil
        }
        do {
            return try decode(T.self)
        } catch {
            do {
                return try decode(JSON.Empty.self).proof()
            } catch(_) {
                return try attemptContainerAgnosticDecodeRecovery(type: T.self, error: error).unwrapOrThrow(error)
            }
        }
    }
}

extension KeyedDecodingContainerProtocol {
    func decodeIfPresentWithRecovery<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T? {
        do {
            return try decodeIfPresent(T.self, forKey: key)
        } catch {
            if let value = attemptDecodeIfPresentRecovery(container: self, type: T.self, key: key, error: error) {
                return value
            } else if let value = attemptContainerAgnosticDecodeRecovery(type: T.self, error: error) {
                return value
            } else {
                throw error
            }
        }
    }
}

extension UnkeyedDecodingContainer {
    mutating func decodeIfPresentWithRecovery<T: Decodable>(_ type: T.Type) throws -> T? {
        guard !isAtEnd else {
            return nil
        }
        do {
            if let decoded = try decodeIfPresent(JSON.self) {
                if decoded.isEmpty {
                    return nil
                } else {
                    return try decoded.decode(T.self)
                }
            } else {
                return nil
            }
        } catch {
            if let value = attemptDecodeIfPresentRecovery(container: self, type: T.self, error: error) {
                return value
            } else if let value = attemptContainerAgnosticDecodeRecovery(type: T.self, error: error) {
                return value
            } else {
                throw error
            }
        }
    }
}
