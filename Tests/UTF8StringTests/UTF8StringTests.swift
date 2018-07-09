import XCTest
@testable import UTF8String

final class UTF8StringTests: XCTestCase {
  func testExample() {
    // TODO:
    //    let str = UTF8String.String("Hello, world!")
    //    print(str)

    let str = UTF8String.String()
    expectTrue(str.isEmpty)

    let hello = UTF8String.String("Hello, world!")
    print("--- Attemping to greet the world ---")
    print(hello)
    print("--- End attempt ---")
  }

  func testUTF8View() {
    let swiftStr = "the quick 🦊 jumped over the lazy brown 🐶"
    let str = UTF8String.String("the quick 🦊 jumped over the lazy brown 🐶")
    expectEqual(swiftStr.utf8.count, str.utf8.count)
    expectEqual(Array(swiftStr.utf8), Array(str.utf8))
    expectEqualSequence(swiftStr.utf8, str.utf8)
  }

  func testUnicodeScalarView() {
    let swiftStr = "the quick 🦊 jumped over the lazy brown 🐶"
    let str = UTF8String.String("the quick 🦊 jumped over the lazy brown 🐶")
    expectEqual(swiftStr.unicodeScalars.count, str.unicodeScalars.count)
    expectEqual(Array(swiftStr.unicodeScalars), Array(str.unicodeScalars))
    expectEqualSequence(swiftStr.unicodeScalars, str.unicodeScalars)
  }

  func testUTF16View() {
    let swiftStr = "the quick 🦊 jumped over the lazy brown 🐶"
    let str = UTF8String.String("the quick 🦊 jumped over the lazy brown 🐶")
    expectEqual(swiftStr.utf16.count, str.utf16.count)
    expectEqual(Array(swiftStr.utf16), Array(str.utf16))
    expectEqualSequence(swiftStr.utf16, str.utf16)
  }

  func testCharacterView() {
    let swiftStr = "the quick 🦊 jumped over the lazy brown 🐶"
    let str = UTF8String.String("the quick 🦊 jumped over the lazy brown 🐶")
    expectEqual(swiftStr.count, str.count)

    // TODO: Need to compare our Character with Swift Character somehow...
//    expectEqual(Array(swiftStr), Array(str))
//    expectEqualSequence(swiftStr, str)
  }

  static var allTests = [
    ("testExample", testExample),
    ]
}
