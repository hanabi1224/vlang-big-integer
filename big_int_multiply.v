module biginteger

pub fn (a BigInteger) * (b BigInteger) BigInteger {
	if a.sign == .zero || b.sign == .zero {
		return zero
	} else {
		// trailing_zeros_a := a.trailing_zeros()
		// trailing_zeros_b := b.trailing_zeros()
		// if (trailing_zeros_a > 0) || (trailing_zeros_b > 0) {
		// 	trailing_zeros := trailing_zeros_a + trailing_zeros_b
		// 	return (a.rshift(trailing_zeros_a) * b.rshift(trailing_zeros_b)).lshift(trailing_zeros)
		// }

		a_len := a.bits.len
		b_len := b.bits.len

		negative := a.sign != b.sign
		array_cap := int(a_len + b_len)
		mut bits := []u32{len: array_cap}
		multiply_unsafe(mut bits, a.bits, b.bits)
		trim_msb_zeros(mut bits)

		return {
			sign: if negative {
				BigIntegerSign.negative
			} else {
				BigIntegerSign.positive
			}
			bits: bits
		}
	}
}

[direct_array_access]
fn multiply_unsafe(mut bits []u32, a []u32, b []u32) {
	a_len := a.len
	b_len := b.len
	if a_len > b_len {
		multiply_unsafe(mut bits, b, a)
		return
	}

	for i := 0; i < a_len; i++ {
		mut tmp_num := u32(0)
		for j := 0; j < b_len; j++ {
			v1 := u64(a[i])
			v2 := u64(b[j])
			i_plus_j := i + j
			product := v1 * v2 + u64(tmp_num) + u64(bits[i_plus_j])
			tmp_num = u32(product >> 32)
			bits[i_plus_j] = u32(product)
		}
		bits[i + b_len] = tmp_num
	}
}
