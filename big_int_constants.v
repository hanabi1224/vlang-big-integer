module biginteger

pub const zero = BigInteger{
	sign: .zero
	bits: [u32(0)]
}
pub const one = BigInteger{
	sign: .positive
	bits: [u32(1)]
}
pub const minus_one = BigInteger{
	sign: .negative
	bits: [u32(1)]
}
pub const two = BigInteger{
	sign: .positive
	bits: [u32(2)]
}
pub const four = BigInteger{
	sign: .positive
	bits: [u32(4)]
}
pub const eight = BigInteger{
	sign: .positive
	bits: [u32(8)]
}
pub const ten = BigInteger{
	sign: .positive
	bits: [u32(10)]
}
pub const hex = BigInteger{
	sign: .positive
	bits: [u32(16)]
}
