module biginteger

fn test_lshift() {
	a := from_str('12_345_678_901_234_567_890') or { panic('') }
	assert a.lshift(2).str() == '49382715604938271560'
	assert a.lshift(31).str() == '26512143563859841556120862720'
	assert a.lshift(32).str() == '53024287127719683112241725440'
	assert a.lshift(33).str() == '106048574255439366224483450880'
}

fn test_rshift() {
	a := from_str('12345678901234567890') or { panic('') }
	assert a.rshift(2).str() == '3086419725308641972'
	assert a.rshift(31).str() == '5748904729'
	assert a.rshift(32).str() == '2874452364'
	assert a.rshift(33).str() == '1437226182'
}
