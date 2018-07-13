// Needed for bridging
import Foundation

// Mockups from Builtin.swift
@inlinable
internal var _objCTaggedPointerBits: UInt {
  @inline(__always) get { return UInt(_swift_BridgeObject_TaggedPointerBits) }
}
@inlinable @inline(__always)
internal func _isObjCTaggedPointer(_ x: AnyObject) -> Bool {
  return (Builtin.reinterpretCast(x) & _objCTaggedPointerBits) != 0
}
@inlinable @inline(__always)
internal func _isObjCTaggedPointer(_ x: UInt) -> Bool {
  return (x & _objCTaggedPointerBits) != 0
}


extension String {
  @inlinable // FIXME(sil-serialize-all)
  public init<Subject>(describing instance: Subject) {
    fatalError()
  }
}

// Mockup from Array shared code
@inlinable
internal func _growArrayCapacity(_ capacity: Int) -> Int {
  return capacity * 2
}

// Forward conformance to stdlib native ones
//extension String: Swift._ExpressibleByBuiltinUnicodeScalarLiteral {}
//extension String: Swift._ExpressibleByBuiltinExtendedGraphemeClusterLiteral {}
//extension String: Swift._ExpressibleByBuiltinUTF16StringLiteral {}
//extension String: Swift._ExpressibleByBuiltinStringLiteral {}
//extension String: Swift.ExpressibleByUnicodeScalarLiteral {}
//extension String: Swift.ExpressibleByExtendedGraphemeClusterLiteral {}
//extension String: Swift.ExpressibleByStringLiteral {}
//
//extension String: Swift.CustomDebugStringConvertible {
//  public var debugDescription: Swift.String {
//    return self.asSwiftString.debugDescription
//  }
//}

// Mockup from UnicodeScalar.swift
extension Unicode.Scalar {
  public init(_unchecked v: UInt32) {
    self = Unicode.Scalar(v)._unsafelyUnwrappedUnchecked
  }
}

import SwiftShims

extension String {
  // Hack to create our new String from toolchain's String
  public init(fromSwiftString s: Swift.StaticString) {
    guard s.hasPointerRepresentation else { fatalError("this hack is for big literals") }
    let bufPtr = UnsafeBufferPointer(
      start: s.utf8Start, count: s.utf8CodeUnitCount)
    self.init(_StringGuts(bufPtr, isKnownASCII: s.isASCII))
  }
  public init(_ s: Swift.String) {
    self.init(decoding: s.utf8, as: UTF8.self)
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



