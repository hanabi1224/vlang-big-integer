module biginteger

pub fn (big BigInteger) negative() BigInteger {
	if big.sign == .zero {
		return big
	}

	return {
		bits: big.bits
		sign: if big.sign == BigIntegerSign.positive {
			BigIntegerSign.negative
		} else {
			BigIntegerSign.positive
		}
	}
}

pub fn (a BigInteger) + (b BigInteger) BigInteger {
	return add(a, b)
}

pub fn add(a BigInteger, b BigInteger) BigInteger {
	if a.sign == .zero {
		return b
	} else if b.sign == .zero {
		return a
	} else if a.sign == b.sign {
		mut bits := []u32{len: 0}
		if a.bits.len > b.bits.len {
			return b + a
		} else {
			bits = add_a_b_length_asc(a.bits, b.bits)
		}

		return {
			sign: a.sign
			bits: bits
		}
	} else {
		mut bits := []u32{len: 0}
		mut sign := BigIntegerSign.zero
		if a.bits.len >= b.bits.len {
			bits, sign = sub_a_b_length_desc(a.bits, b.bits, if a.sign == BigIntegerSign.negative {
				true
			} else {
				false
			})
		} else {
			return b + a
		}

		if sign == .zero {
			return zero
		}

		return {
			sign: sign
			bits: bits
		}
	}
}

pub fn (a BigInteger) - (b BigInteger) BigInteger {
	return substract(a, b)
}

pub fn substract(a BigInteger, b BigInteger) BigInteger {
	if a.sign == .zero {
		return b.negative()
	} else if b.sign == .zero {
		return a
	} else if a.sign != b.sign {
		mut bits := []u32{len: 0}
		if a.bits.len >= b.bits.len {
			bits = add_a_b_length_asc(b.bits, a.bits)
		} else {
			println('here2 a:$a, b:$b')
			return substract(b, a).negative()
		}

		return {
			sign: a.sign
			bits: bits
		}
	} else {
		mut bits := []u32{len: 0}
		mut sign := BigIntegerSign.zero
		if a.bits.len >= b.bits.len {
			bits, sign = sub_a_b_length_desc(a.bits, b.bits, if a.sign == BigIntegerSign.negative {
				true
			} else {
				false
			})
		} else {
			return substract(b, a).negative()
		}

		if sign == .zero {
			return zero
		}

		return {
			sign: sign
			bits: bits
		}
	}
}

// length of a is ganranteed to be smaller than b
[direct_array_access]
fn add_a_b_length_asc(a []u32, b []u32) []u32 {
	mut i := 0
	mut num_tmp := u64(0)
	mut result := []u32{len: b.len + 1}
	for ; i < a.len; i++ {
		num := u64(a[i]) + u64(b[i]) + num_tmp
		num_tmp = num >> 32
		result[i] = u32(num)
	}

	for ; i < b.len; i++ {
		num := u64(b[i]) + num_tmp
		num_tmp = num >> 32
		result[i] = u32(num)
	}

	if num_tmp > 0 {
		result[i] = u32(num_tmp)
	} else {
		result.delete_last()
	}

	return result
}

[direct_array_access]
fn sub_a_b_length_desc(a []u32, b []u32, reverse_sign bool) ([]u32, BigIntegerSign) {
	mut i := 0
	mut result := []u32{len: a.len + 1}
	mut borrow_next := false
	for ; i < b.len; i++ {
		v1 := i64(a[i])
		v2 := i64(b[i])
		mut diff := v1 - v2
		if borrow_next {
			diff = diff - 1
			borrow_next = false
		}

		if diff < 0 {
			borrow_next = true
			diff += (1 << 32)
		}

		result[i] = u32(diff)
	}

	for ; i < a.len; i++ {
		mut diff := i64(a[i])
		if borrow_next {
			diff = diff - 1
			borrow_next = false
		}

		if diff < 0 {
			borrow_next = true
			diff += (1 << 32)
		}

		result[i] = u32(diff)
	}

	mut sign := BigIntegerSign.positive
	if borrow_next {
		sign = BigIntegerSign.negative
		result[i] = 1
	} else {
		trim_msb_zeros(mut result)
		if i < 0 {
			sign = BigIntegerSign.zero
		}
	}

	if reverse_sign && sign != BigIntegerSign.zero {
		sign = if sign == BigIntegerSign.positive {
			BigIntegerSign.negative
		} else {
			BigIntegerSign.positive
		}
	}

	return result, sign
}
