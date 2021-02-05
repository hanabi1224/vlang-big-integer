module biginteger

enum BigIntegerSign {
	negative = -1
	zero = 0
	positive = 1
}

pub struct BigInteger {
	bits []u32
pub:
	sign BigIntegerSign
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
