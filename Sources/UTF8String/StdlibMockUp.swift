// Needed for bridging
import Foundation

//public typealias Builtin = SwiftBuiltin

// TODO: Temporary, remove when StringIndex.swift migrates
extension String {
  @inlinable // FIXME(sil-serialize-all)
  public init<Subject>(describing instance: Subject) {
    fatalError()
  }
}

// Forward conformance to stdlib native ones
extension String: Swift._ExpressibleByBuiltinUnicodeScalarLiteral {}
extension String: Swift._ExpressibleByBuiltinExtendedGraphemeClusterLiteral {}
extension String: Swift._ExpressibleByBuiltinUTF16StringLiteral {}
extension String: Swift._ExpressibleByBuiltinStringLiteral {}
//extension String: Swift.ExpressibleByUnicodeScalarLiteral {}
//extension String: Swift.ExpressibleByExtendedGraphemeClusterLiteral {}
//extension String: Swift.ExpressibleByStringLiteral {}
//
//extension String: Swift.CustomDebugStringConvertible {
//  public var debugDescription: Swift.String {
//    return self.asSwiftString.debugDescription
//  }
//}

extension Unicode.Scalar {
  @inlinable
  @_transparent
  public init(_builtinUnicodeScalarLiteral value: Builtin.Int32) {
    self.init(UInt32(value))!
  }

  public init(_unchecked v: UInt32) {
    self = Unicode.Scalar(v)._unsafelyUnwrappedUnchecked
  }
}

import SwiftShims

extension String {
  // Hack to create our new String from toolchain's String
  public init(_ s: Swift.StaticString) {
    guard s.hasPointerRepresentation else { fatalError("this hack is for big literals") }
    let bufPtr = UnsafeBufferPointer(
      start: s.utf8Start, count: s.utf8CodeUnitCount)
    self.init(_StringGuts(bufPtr, isKnownASCII: s.isASCII))
  }

  public var asSwiftString: Swift.String {
    return Swift.String(decoding: self.utf8, as: UTF8.self)
  }
}

// Mock up print(str)
public func print(_ s: String) {
  print(s.asSwiftString)
}

// Mock up dump(str)
public func dump(_ s: String) {
  dump(s.asSwiftString)
}



