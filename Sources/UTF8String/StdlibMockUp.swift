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
    self.init(Swift.String(describing: instance))
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

// Mockup from Assert.swift
//@inlinable @_transparent
//public func fatalError(
//  _ message: @autoclosure () -> String = String(),
//  file: StaticString = #file, line: UInt = #line
//) -> Never {
//  Swift.fatalError()
//}
@inlinable @_transparent
public func _sanityCheck(
  _ condition: @autoclosure () -> Bool, _ message: Swift.StaticString = Swift.StaticString(),
  file: StaticString = #file, line: UInt = #line
  ) {
  #if INTERNAL_CHECKS_ENABLED
  guard condition() else {
    _preconditionFailure(message, file: file, line: line)
  }
  #endif
}
@inlinable @_transparent
public func _sanityCheckFailure(
  _ message: StaticString = StaticString(),
  file: StaticString = #file, line: UInt = #line
  ) -> Never {
  _sanityCheck(false, message, file: file, line: line)
}

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
    let codeUnits = Array(s.utf8)
    self = codeUnits.withUnsafeBufferPointer { String._uncheckedFromUTF8($0) }
  }

  public var asSwiftString: Swift.String {
    return Swift.String(decoding: self.utf8, as: UTF8.self)
  }

  // From Mirror.swift
  public init<Subject>(reflecting subject: Subject) {
    self.init(Swift.String(reflecting: subject))
  }

}

public func print(
  _ items: Any...,
  separator: String = " ",
  terminator: String = "\n",
  to output: inout String
) {
  var swiftStr = Swift.String()
  var prefix: Swift.String = ""
  for item in items {
    Swift.print(prefix, separator: "", terminator: "", to: &swiftStr)
    Swift.print(
      item, separator: "", terminator: Swift.String(), to: &swiftStr)
    prefix = separator.asSwiftString
  }
  Swift.print(
    "", separator: "", terminator: terminator.asSwiftString, to: &swiftStr)
  output += String(swiftStr)
}

//// Mock up print(str)
//public func print(_ s: String) {
//  print(s.asSwiftString)
//}
//
//// Mock up dump(str)
//public func dump(_ s: String) {
//  dump(s.asSwiftString)
//}



