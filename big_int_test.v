module biginteger

fn test_multiply() {
	a := from_str('12345678901234567890') or { panic('') }
	b := from_str('98765432109876543210') or { panic('') }

	assert '${a * b}' == '1219326311370217952237463801111263526900'
}

fn test_mult1() {
	a := from_str('12345678901234567890') or { panic('') }
	b := from_str('281474976710656') or { panic('') }

	assert '${a * b}' == '3474999681202237152443873718435840'
}

fn test_mult2() {
	a := from_str('12345678901234567890') or { panic('') }
	// b := from_str('281474976710656') or { panic('') }

	assert '${a.lshift(48)}' == '3474999681202237152443873718435840'
}

fn test_mult3() {
	mut a := from_str('12345678901234567890') or { panic('') }
	a = a.lshift(2)
	mut b := from_str('281474976710656') or { panic('') }
	b = b.lshift(4)

	assert '${a * b}' == '222399979596943177756407917979893760'
}

fn test_div1() {
	a := from_str('12345678901234567890') or { panic('') }
	b := from_str('281474976710656') or { panic('') }

	assert '${a / b}' == '43860'
}

fn test_div2() {
	a := from_str('12345678901234567890') or { panic('') }
	// b := from_str('281474976710656') or { panic('') }

	assert '${a.rshift(48)}' == '43860'
}

fn test_tailing_zeros() {
	assert zero.trailing_zeros() == 0
	assert one.trailing_zeros() == 0
	assert two.trailing_zeros() == 1
	for i in 0 .. 128 {
		big := one.lshift(u64(i))
		assert big.trailing_zeros() == i
	}
}

fn test_leading_zeros() {
	assert zero.leading_zeros() == 32
	assert one.leading_zeros() == 31
	assert two.leading_zeros() == 30
}
