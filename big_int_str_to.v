module big_int

import strings

fn (big BigInteger) str() string {
	if big.sign == .zero {
		return '0'
	}
	// println('[$big.sign]$big.bits')
	// TODO: optimize init size
	mut builder := strings.new_builder(1)
	if big.sign == .negative {
		builder.write('-')
	}

	base := u32(10)
	mut txt := ''

	mut bits := []u64{}
	for b in big.bits {
		bits << u64(b)
	}

	mut remainder := bits[0]
	for remainder > 0 {
		for i := bits.len - 1; i > 0; i-- {
			tmp_bits := bits[i]
			tmp_bits_mod := tmp_bits % base
			tmp_bits_remaider := tmp_bits / base
			if tmp_bits_remaider > 0 {
				bits[i] = tmp_bits_remaider
			} else {
				bits.delete_last()
			}

			if tmp_bits_mod > 0 {
				bits[i - 1] += (tmp_bits_mod << 32)
			}
		}

		d0 := bits[0]
		mod := d0 % base
		remainder = d0 / base

		if mod == 0 && remainder == 0 && bits.len == 1 {
		} else {
			txt = '$mod$txt'
			bits[0] = remainder
		}
	}

	builder.write(txt)
	ret := builder.str()
	// println(ret)
	return ret
}
