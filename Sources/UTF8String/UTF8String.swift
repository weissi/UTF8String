
extension Bool {
  @inlinable @inline(__always) @_transparent
  internal init(_ v: Builtin.Int1) { self = Builtin.reinterpretCast(v) }
}
