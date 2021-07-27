module biginteger

pub const (
	zero = BigInteger{
		sign: .zero
		bits: [u32(0)]
	}
	one = BigInteger{
		sign: .positive
		bits: [u32(1)]
	}
	minus_one = BigInteger{
		sign: .negative
		bits: [u32(1)]
	}
	two = BigInteger{
		sign: .positive
		bits: [u32(2)]
	}
	four = BigInteger{
		sign: .positive
		bits: [u32(4)]
	}
	eight = BigInteger{
		sign: .positive
		bits: [u32(8)]
	}
	ten = BigInteger{
		sign: .positive
		bits: [u32(10)]
	}
	hex = BigInteger{
		sign: .positive
		bits: [u32(16)]
	}
)
