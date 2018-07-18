
//@usableFromInline
//func helloWorld() {
//  print("Hello, world!")
//}

//
// Test out some bit formations to see the price of forming immediates
//

public func imm_addmask() -> UInt {
  return 0x00FF_FFFF_FFFF_FFFF
}

public func imm_topbytemask() -> UInt {
  return 0xFF00_0000_0000_0000
}

public func imm_empty(_ x: UInt) -> UInt {
  return x | 0xD000_0000_0000_0000
}

public func imm_empty_alt(_ x: UInt) -> UInt {
  return x | 0xA000_0000_0000_0000
}

public func imm_empty_alt_2(_ x: UInt) -> UInt {
  return x | 0xB000_0000_0000_0000
}


public func imm_empty_alt_3(_ x: UInt) -> UInt {
  return x | 0xB000_0000_0000_0000
}

public func imm_empty_alt_3_add(_ x: UInt) -> UInt {
  return x &+ 0xB000_0000_0000_0000
}

public func imm_empty_alt_4(_ x: UInt) -> UInt {
  return x | 0xF000_0000_0000_0000
}

// ARM64 immediate-logical operations have a different immediate encoding strategy.
// They seem to only represent

public func imm_arm_1(_ x: UInt) -> UInt {
  return x | 0x8000000000000000
}
public func imm_arm_2(_ x: UInt) -> UInt {
  return x | 0xC000000000000000
}
public func imm_arm_3(_ x: UInt) -> UInt {
  return x | 0xE000000000000000
}
public func imm_arm_4(_ x: UInt) -> UInt {
  return x | 0xF000000000000000
}
public func imm_arm_5(_ x: UInt) -> UInt {
  return x | 0xF800000000000000
}
public func imm_arm_6(_ x: UInt) -> UInt {
  return x | 0xFC00000000000000
}
public func imm_arm_7(_ x: UInt) -> UInt {
  return x | 0xFE00000000000000
}

public func imm_arm_8(_ x: UInt) -> UInt {
  return x | 0xFF00000000000000
}

public func imm_arm_9(_ x: UInt) -> UInt {
  return x | 0xFF80000000000000
}

public func imm_arm_10(_ x: UInt) -> UInt {
  return x | 0xFFC0000000000000
}

public func imm_arm_11(_ x: UInt) -> UInt {
  return x | 0xFFE0000000000000
}


