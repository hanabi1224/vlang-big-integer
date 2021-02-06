module biginteger

import math.bits

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

pub fn (big BigInteger) trailing_zeros() u64 {
	if big == zero {
		return 0
	}

	mut sum := u64(0)
	for b in big.bits {
		if b == 0 {
			sum = sum + 32
		} else {
			sum = sum + u64(bits.trailing_zeros_32(b))
			break
		}
	}

	return sum
}

pub fn (big BigInteger) leading_zeros() u64 {
	return u64(bits.leading_zeros_32(big.bits.last()))
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
			if bits[i] == 0 {
				bits.delete_last()
			} else {
				break
			}
		}
	}
}
