module biginteger

enum BigIntegerSign {
	negative = -1
	zero = 0
	positive = 1
}

pub struct BigInteger {
mut:
	bits []u32
pub:
	sign BigIntegerSign
}

fn (mut big BigInteger) prepend_bit(b u32) {
	big.bits.prepend(b)
}

fn (mut big BigInteger) append_bit(b u32) {
	big.bits << b
}

fn (big BigInteger) clone() BigInteger {
	return {
		sign: big.sign
		bits: big.bits.clone()
	}
}

fn trim_msb_zeros(mut bits []u32) {
	if bits.len > 0 {
		for i := bits.len - 1; i > 0; i-- {
			digit := bits[i]
			if digit == 0 {
				bits.delete_last()
			} else {
				break
			}
		}
	}
}
