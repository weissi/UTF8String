import XCTest
@testable import UTF8String

func expectPrototypeEquivalence(
  _ str: UTF8String.String, _ swiftStr:  Swift.String
) {
  guard str.map({ Array($0.unicodeScalars) })
        == swiftStr.map({ Array($0.unicodeScalars) })
  else { expectTrue(false) ; return }
  guard str.utf8.elementsEqual(swiftStr.utf8),
        str.utf16.elementsEqual(swiftStr.utf16),
        str.unicodeScalars.elementsEqual(swiftStr.unicodeScalars)
  else { expectTrue(false) ; return }
  expectTrue(true)
}

final class UTF8StringTests: XCTestCase {
  let swiftStr = "the quick 🦊 jumped over the lazy brown 🐶"
  let str = "the quick 🦊 jumped over the lazy brown 🐶" as UTF8String.String

  let cafe = "café" as UTF8String.String
  let cafe2 = "cafe\u{301}" as UTF8String.String

  let swiftCafe = "café"
  let swiftCafe2 = "cafe\u{301}"

  func testExample() {
    // Make sure the types are different
    expectFalse(type(of: swiftStr) == type(of: str))

    let str = UTF8String.String()
    expectTrue(str.isEmpty)

    let hello = "Hello, world!" as UTF8String.String
    print("--- Attemping to greet the world ---")
    print(hello)
    print("--- End attempt ---")

    expectPrototypeEquivalence(hello, "Hello, world!")
  }

  func testUTF8View() {
    expectEqual(swiftStr.utf8.count, str.utf8.count)
    expectEqual(Array(swiftStr.utf8), Array(str.utf8))
    expectEqualSequence(swiftStr.utf8, str.utf8)
  }

  func testUnicodeScalarView() {
    expectEqual(swiftStr.unicodeScalars.count, str.unicodeScalars.count)
    expectEqual(Array(swiftStr.unicodeScalars), Array(str.unicodeScalars))
    expectEqualSequence(swiftStr.unicodeScalars, str.unicodeScalars)
  }

  func testUTF16View() {
    expectEqual(swiftStr.utf16.count, str.utf16.count)
    expectEqual(Array(swiftStr.utf16), Array(str.utf16))
    expectEqualSequence(swiftStr.utf16, str.utf16)
  }

  func testCharacterView() {
    expectEqual(swiftStr.count, str.count)
    expectPrototypeEquivalence(str, swiftStr)
  }

  func testBridging() {
    let bridgedSmol = UTF8String.String(_cocoaString: "abc" as NSString)

    expectTrue(bridgedSmol._guts._object.isSmall)

    let abc = "abc"
    expectPrototypeEquivalence(bridgedSmol, abc)
    expectEqualSequence(bridgedSmol.utf8, abc.utf8)
    expectEqualSequence(bridgedSmol.utf16, abc.utf16)
    expectEqualSequence(bridgedSmol.unicodeScalars, abc.unicodeScalars)


    // NOTE: literal intentional for testing purposes...
    let bridgedLarge = UTF8String.String(_cocoaString: "abcdefghijklmnopqrstuvwxyz" as NSString)

    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    expectPrototypeEquivalence(bridgedLarge, alphabet)
  }

  func testComparision() {

    print(cafe)
    print(cafe2)

    expectPrototypeEquivalence(cafe, swiftCafe)
    expectPrototypeEquivalence(cafe2, swiftCafe2)
    expectFalse(cafe.utf8.elementsEqual(cafe2.utf8))
    expectFalse(cafe.unicodeScalars.elementsEqual(cafe2.unicodeScalars))

    expectEqual(swiftCafe, swiftCafe2)
    expectEqual(cafe, cafe2)
  }

  func testHashing() {
    let cafe = "café" as UTF8String.String
    let cafe2 = "cafe\u{301}" as UTF8String.String

    expectFalse(cafe.unicodeScalars.elementsEqual(cafe2.unicodeScalars))
    expectEqual(cafe.hashValue, cafe2.hashValue)

    expectEqual(cafe.map { $0.hashValue }, cafe2.map { $0.hashValue })
  }

  func testSorting() {
    let abc = "abc" as UTF8String.String
    let swiftABC = "abc"

    let def = "def" as UTF8String.String
    let swiftDEF = "def"

    let arr = [def, cafe, str, abc].shuffled().sorted()
    let swiftArr = [
      swiftDEF, swiftCafe, swiftStr, swiftABC
    ].shuffled().sorted()

    for (x, y) in zip(arr, swiftArr) {
      expectPrototypeEquivalence(x, y)
    }

    expectEqualSequence(
      (arr + [cafe2]).shuffled().sorted(),
      [abc, cafe, cafe2, def, str])
    expectEqualSequence(
      (arr + [cafe2]).shuffled().sorted(),
      [abc, cafe2, cafe, def, str])
  }

  func testInterpolation() {
    let def = "def" as UTF8String.String
    let swiftDEF = "def"

    let interp = "abc\(def)ghijklmnop" as UTF8String.String
    let swiftInterp = "abc\(swiftDEF)ghijklmnop"

    expectPrototypeEquivalence(interp, swiftInterp)

    let uniInterp = "abc\(str)" as UTF8String.String
    let swiftUniInterp = "abc\(swiftStr)"

    expectPrototypeEquivalence(uniInterp, swiftUniInterp)


  }

  func testPrinting() {
    var result = "" as UTF8String.String
    var swiftResult = ""

    UTF8String.print(1, to: &result)
    print(1, to: &swiftResult)

    UTF8String.print(5.25, to: &result)
    print(5.25, to: &swiftResult)

    expectPrototypeEquivalence(result, swiftResult)
  }

  func testCString() {
    let cStr = str.utf8CString
    let swiftCStr = swiftStr.utf8CString
    expectEqual(cStr, swiftCStr)

    // TODO: others...
  }

  func testStringCreate() {
    let utf8 = UTF8String.String(decoding: str.utf8, as: UTF8.self)
    let utf16 = UTF8String.String(decoding: str.utf16, as: UTF16.self)
    let utf32 = UTF8String.String(
      decoding: str.unicodeScalars.map { $0.value }, as: UTF32.self)

    let swiftUTF8 = Swift.String(decoding: swiftStr.utf8, as: UTF8.self)
    let swiftUTF16 = Swift.String(decoding: swiftStr.utf16, as: UTF16.self)
    let swiftUTF32 = Swift.String(
      decoding: swiftStr.unicodeScalars.map { $0.value }, as: UTF32.self)

    expectPrototypeEquivalence(utf8, swiftUTF8)
    expectPrototypeEquivalence(utf16, swiftUTF16)
    expectPrototypeEquivalence(utf32, swiftUTF32)

    // TODO: others...
  }

//  static var allTests = [
//    ("testExample", testExample),
//    ]
}

