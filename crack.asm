//0047148B | 55                       | push ebp        
//00475018 0000010C


mov $addrIat,0x00475000
mov $addrIatEnd,   0x00475120


fix_loop:
	mov $addrIatItem,dword:[$addrIat]
	cmp $addrIatItem,0
	je fix_next

	//����Ϊ�µ�EIP��ַ
	mov cip,$addrIatItem
find_ret:
	sti

	//�ж��Ƿ���ret
	cmp byte:[cip],0xc3
	jnz find_ret

	//����ret��ȡջ���ĵ�ַ�������Ӧ��IAT
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