import XCTest
import Swift

public func expectEqual<T>(
  _ expression1: @autoclosure () throws -> T,
  _ expression2: @autoclosure () throws -> T,
  file: StaticString = #file, line: UInt = #line
  ) where T : Equatable {
  XCTAssertEqual(expression1, expression2, file: file, line: line)
}


public func expectEqualSequence<T, S>(
  _ expression1: @autoclosure () throws -> T,
  _ expression2: @autoclosure () throws -> S,
  file: StaticString = #file, line: UInt = #line
  ) where T: Sequence, S: Sequence, T.Element: Equatable, S.Element == T.Element {
  expectEqual(Array(try expression1()), Array(try expression2()), file: file, line: line)
}


public func expectNotNil<T>(
  _ x: Optional<T>,
  file: StaticString = #file, line: UInt = #line
  ) {
  XCTAssertNotNil(x, file: file, line: line)
}

public func expectTrue(
  _ expression1: @autoclosure () throws -> Bool,
  file: StaticString = #file, line: UInt = #line
  ) {
  XCTAssert(try expression1(), file: file, line: line)
}

public func expectFalse(
  _ expression1: @autoclosure () throws -> Bool,
  file: StaticString = #file, line: UInt = #line
  ) {
  XCTAssertFalse(try expression1(), file: file, line: line)
}

public func expectDoesNotThrow<T>(
  _ expression1: @autoclosure () throws -> T,
  file: StaticString = #file, line: UInt = #line
  ) {
  XCTAssertNoThrow(expression1, file: file, line: line)
}


public func expectThrows<T, E: Error>(
  _ err: E,
  _ expression1: () throws -> T,
  file: StaticString = #file, line: UInt = #line
  ) where E: Equatable {
  do {
    try _ = expression1()
    XCTFail("no throw", file: file, line: line)
  } catch {
    guard let e = error as? E else {
      XCTFail("wrong error type thrown", file: file, line: line)
      return
    }
    expectEqual(err, e, file: file, line: line)
  }
}
