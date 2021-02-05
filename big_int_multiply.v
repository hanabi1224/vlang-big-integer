module biginteger

pub fn (a BigInteger) * (b BigInteger) BigInteger {
	if a.sign == .zero || b.sign == .zero {
		return zero
	} else {
		a_len := a.bits.len
		b_len := b.bits.len

		negative := a.sign != b.sign
		array_cap := int(a_len + b_len)
		mut bits := []u32{len: array_cap, init: 0}

		for i := 0; i < a_len; i++ {
			mut tmp_num := u32(0)
			for j := 0; j < b_len; j++ {
				v1 := u64(a.bits[i])
				v2 := u64(b.bits[j])
				i_plus_j := i + j
				product := v1 * v2 + u64(tmp_num) + u64(bits[i_plus_j])
				tmp_num = u32(product >> 32)
				bits[i_plus_j] = u32(product)
			}
			bits[i + b_len] = tmp_num
		}

		for i := bits.len - 1; i >= 0; i-- {
			if bits[i] == 0 {
				bits.delete_last()
			}
		}

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
