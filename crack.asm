//0047148B | 55                       | push ebp        
//00475018 0000010C


mov $addrIat,0x00475000
mov $addrIatEnd,   0x00475120


fix_loop:
	mov $addrIatItem,dword:[$addrIat]
	cmp $addrIatItem,0
	je fix_next

	//设置为新的EIP地址
	mov cip,$addrIatItem
find_ret:
	sti

	//判断是否到了ret
	cmp byte:[cip],0xc3
	jnz find_ret

	//到了ret，取栈顶的地址，存入对应的IAT
	mov dword:[$addrIat],dword:[csp]
	log "fix old addr {p:$addrIatItem} -->{p:dword:[csp]}"
	jmp fix_next
	jmp find_ret

fix_next:
	add $addrIat,4
	cmp $addrIat,$addrIatEnd
	je exit
	jmp fix_loop
exit:
ret