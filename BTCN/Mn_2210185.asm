#Câu 1: Viết chương trình MARS MIPS dùng chức năng set seed (syscall 40) theo time (syscall 30) 
#và các chức năng phát số ngẫu nhiên để phát ra 3 số ngẫu nhiên fi (0<fi<1000). In ra màn hình và 
#lưu các số này lên tập tin SOLE.TXT trên đĩa thành 3 dòng như sau: 
#So f1 (2 so le): fff.ff 
#So f2 (3 so le): fff.fff 
#So f3 (4 so le): fff.ffff 

#Chuong trinh: SOLE
		
#Data segment
	.data result1 
	.data result2
	.data result3
	.data xuat_f1
	.data xuat_f2
	.data xuat_f3
	.data count
	.data endl
	.data filename
	.data numdigit
	.data textdigit
#Cac dinh nghia bien
	count:.word 0					#So ki tu lam tron	
	numdigit:.word 0				#Do dai cua chuoi so
	textdigit:.word 17				#Do dai cua chuoi ki tu,  cả 13 câu nhắc dữ liệu đều có độ dài là 17 không kể \0
	filename:.asciiz "SOLE.TXT"			#Ten File
	endl:.asciiz "\n"				#Ki tu xuong dong
	xuat_f1:.asciiz "So f1 (2 so le): "		#Cau nhac so thuc 1
	xuat_f2:.asciiz "So f2 (3 so le): " 		#Cau nhac so thuc 2
	xuat_f3:.asciiz "So f3 (4 so le): "  		#Cau nhac so thuc 3
	result1:.space 11				#Tạo mảng kí tự rỗng để chữa chuõi kết quả 1
	result2:.space 11				#Tạo mảng kí tự rỗng để chữa chuõi kết quả 2
	result3:.space 11				#Tạo mảng kí tự rỗng để chữa chuõi kết quả 3

	
#Cac cau nhac nhap du lieu
#Code segment
	.text
	
main:	
#Nhap (syscall)
#tXu ly

# Mở file ở chế độ ghi
    	li $v0, 13	
    	la $a0, filename		#Gán địa chỉ của file		
    	li $a1, 1			# a1: flag
    	li $a2, 0			# a2: mode
    	syscall				#syscall v0 = 13 để mở chế độ ghi file
    	move $s7, $v0
 
# So thuc f1 	
 	#Sinh số thực f1 ngẫu nhiên làm tròn 2 chữ số
    	jal random_float 		#Sinh ra số thực ngẫu nhiên , số thực được trả tại thanh ghi $f1    	
	li $a1,2			#a1 chứa số chữ số làm tròn là 2
	la $a2,result1			#a2 chứa địa chỉ mảng kết quả của số sau khi làm tròn
	jal set_precision		#Gọi hàm làm tròn chữ số set precision với cac thanh ghi tham số $f1,$a1,$a2,$v1 
	
	#Lưu kết quả số thực 1 làm tròn 2 chữ số vào trong file "SOLE.TXT"
	li $v0, 15			#Gọi lệnh ghi vào trong file Syscall 15	
    	move $a0, $s7
    	la $a1, xuat_f1			#$a1 chứa địa chỉ của chuỗi cần ghi
    	lw $a2, textdigit		#$a2 chứa số kí tư trong chuỗi
    	syscall				#Lưu câu nhắc vào trong file
    	
    	li $v0, 15
    	la $a1, result1			#$a1 chứa địa chỉ của chuỗi kết quả 1 
    	move $a2, $v1			#Chuyến số kí tự của chuõi kết quả 1 vào trong thanh ghi $a2
    	syscall				#Lưu chuỗi kết quả vào trong file
    	
    	li $v0, 15
    	la $a1, endl
    	li $a2, 1	
    	syscall				#In kí tự xuống dòng vào trong file
    		
# So thuc f2  	
	#Sinh số thực f2 ngẫu nhiên làm tròn 3 chữ số
    	jal random_float 		#Sinh ra số thực ngẫu nhiên , số thực được trả tại thanh ghi $f1
	li $a1,3			#a1 chứa số chữ số làm tròn là 2
	la $a2,result2			#a2 chứa địa chỉ mảng kết quả của số sau khi làm tròn
	jal set_precision		#Gọi hàm làm tròn chữ số set precision với cac thanh ghi tham số $f1,$a1,$a2,$v1 
	
	#Lưu kết quả số thực 2 làm tròn 3 chữ số vào trong file "SOLE.TXT"
	li $v0, 15			#Gọi lệnh ghi vào trong file Syscall 15	
    	move $a0, $s7
    	la $a1, xuat_f2			#$a1 chứa địa chỉ của chuỗi cần ghi
    	lw $a2, textdigit		#$a2 chứa số kí tư trong chuỗi
    	syscall				#Lưu câu nhắc vào trong file
    	
    	li $v0, 15
    	la $a1, result2			#$a1 chứa địa chỉ của chuỗi kết quả 2 
    	move $a2, $v1			#Chuyến số kí tự của chuõi kết quả 2 vào trong thanh ghi $a2
    	syscall				#Lưu chuỗi kết quả vào trong file
    	
    	li $v0, 15
    	la $a1, endl
    	li $a2, 1	
    	syscall				#In kí tự xuống dòng vào trong file
	
# So thuc f3 	
	#Sinh số thực f3 ngẫu nhiên làm tròn 4 chữ số
    	jal random_float 		#Sinh ra số thực ngẫu nhiên , số thực được trả tại thanh ghi $f1
	li $a1,4			#a1 chứa số chữ số làm tròn là 2
	la $a2,result3			#a2 chứa địa chỉ mảng kết quả của số sau khi làm tròn
	jal set_precision		#Gọi hàm làm tròn chữ số set precision với cac thanh ghi tham số $f1,$a1,$a2,$v1 
	
	#Lưu kết quả số thực 2 làm tròn 3 chữ số vào trong file "SOLE.TXT"
	li $v0, 15			#Gọi lệnh ghi vào trong file Syscall 15	
    	move $a0, $s7
    	la $a1, xuat_f3		#$a1 chứa địa chỉ của chuỗi cần ghi
    	lw $a2, textdigit		#$a2 chứa số kí tư trong chuỗi
    	syscall				#Lưu câu nhắc vào trong file
    	
    	li $v0, 15
    	la $a1, result3			#$a1 chứa địa chỉ của chuỗi kết quả 2 
    	move $a2, $v1			#Chuyến số kí tự của chuõi kết quả 2 vào trong thanh ghi $a2
    	syscall				#Lưu chuỗi kết quả vào trong file
    	
    	li $v0, 15
    	la $a1, endl
    	li $a2, 1	
    	syscall				#In kí tự xuống dòng vào trong file
    	
#Đóng file
	li $v0, 16
    	move $a0, $s7
    	syscall

#Xuat ket qua (syscall)
	#In kết quả số thực f1 làm tròn 2 chữ số ra màn hình
	li $v0,4
	la $a0, xuat_f1
	syscall	
	la $a0, result1
	syscall	
	la $a0, endl
	syscall
			
	#In kết quả số thực f2 làm tròn 3 chữ số ra màn hình
	li $v0,4
	la $a0, xuat_f2
	syscall	
	la $a0, result2
	syscall	
	la $a0, endl
	syscall
		
	#In kết quả số thực f3 làm tròn 4 chữ số ra màn hình
	li $v0,4
	la $a0, xuat_f3
	syscall	
	la $a0, result3
	syscall	
	
#ket thuc chuong trinh (syscall)
Kthuc:	addi	$v0,$zero,10
	syscall
	
# -------------------------------	
# Cac chuong trinh khac
# -------------------------------

#Hàm sinh so thuc ngau nhien randomfloat từ 0 < f < 1000
	#Quy ước thanh ghi các tham số và kết quả trả về:
		# Thanh ghi $f1 chứa số thực ngẫu nhiên  
random_float:	
	li $v0, 30			# Lấy thời gian hệ thống			
	syscall
	move $t0, $v0			# Lưu kết quả của syscall 30 vào $t0

	li $v0, 40			# Thiết lập seed sử dụng thời gian hiện tại
	move $a0, $t0
	syscall
					
	li $a0,1000			# So nguyen (1000)
	mtc1 $a0, $f1 
	cvt.s.w $f1, $f1 		#Chuyen so nguyen sang so thuc 
	
float:					# So thuc random (0;1)
	li $v0, 43			# Sinh so thuc float [0;1)
	syscall
	mfc1 $t1,$f0
	beq $t1,0,float			#Trường hợp bằng 0.0 thì sinh ra một số khác
	mul.s $f1,$f0,$f1		#Nhan so thuc a(0,1)x 1000 = b(0,1000), lưu số thực đó vào thanh ghi $f1			
	jr $ra

#/////////////////////////////////////////////////////////////////

#Hàm làm tròn số thực set_presision
	#Quy ước thanh ghi các tham số và kết quả trả về:
		# Thanh ghi $f1 chứa số thực
		# Thanh ghi $a1 chứa số ki tự làm tròn 
		# Thanh shi $a2 chứa địa chỉ của chuõi số sau khi được làm tròn
		# Thanh ghi $v1 trả về số kí tự của chuỗi số sau khi được làm tròn
		
	#Quy ước các thanh ghi cần sử dụng:
		#s0: 10^n+1
		#s1: Số cần làm tròn
		#S2: Dấu của só
		#s3: Số chữ số làm tròn
		#s4: Số lượng các chữ số
		#s5: Địa chỉ mảng 
		#s6: Biến cờ cho biết số có bé hơn 1 hay không

set_precision:
	addi $s0,$0,1 				#Biến tạm lưu số 10^(n), với n là số chữ số làm tròn
	addi $t1,$0,0 				#i=0
	move $s3,$a1 				#Tải số chữ số làm tròn precision_count
	addi $t2,$s3,1 				#precision_count+1
	addi $t3,$0,10 				# t3 = 10
while: 	
	beq $t1,$t2,endwhile 			#i = precision_count+1
      	addi $t1,$t1,1				#i+=1
      	mul  $s0,$s0,$t3 			#s0*=10
      	j while
      	
endwhile: 
      	mtc1 $s0, $f0      			# Chuyển kết quả từ $t0 sang thanh ghi số thực $f0
	cvt.s.w $f0, $f0   			# Chuyển đổi số nguyên trong $f0 thành số thực			
	mul.s $f2,$f0,$f1			# float_num * 10^(n+1), tich f2
	cvt.w.s $f2, $f2    			# Chuyển đổi số thực trong $f2 sang số nguyên
	mfc1 $s1, $f2       			# Chuyển kết quả từ thanh ghi số thực $f2 sang thanh ghi số nguyên $s1     	
     	
     	slti $s2,$s1,0				# Xét dấu của số số
     	bne  $s2,1, pos				# Đổi sang số dương nếu là số âm
     	neg $s1,$s1
	
pos:     	
     	sltu $s6,$s1,$s0			#Xét xem số đó có bé hơn 1 hay không		
     	div $s1,$t3 
     	mflo $s1				#Phần được làm tròn lưu vào thanh ghi $s1
     	mfhi $t1
     	slti $t0,$t1,5
     	beq $t0,1, precision			#Nếu số kề só được làm tròn bé hơn 5 thì làm tròn số lên 1
     	addi $s1,$s1,1				#da lam tron     	
     	
precision:
	li $s4,0				#Gán số lượng các chữ số bằng 0
	move $s5,$a2 				#Lấy địa chỉ của mảng chuỗi kết quả
	
loop:		
	beq $s4,$s3,point			#khi số kí tự của chuỗi bằng số chữ số làm tròn thì thêm dấu chấm thập phân
	div $s1, $t3				#Nếu không thì lần lượt chia số cho 10 để lấy các chữ số , thanh ghi $t3 chứa số 10
	mflo $t1
	mfhi $t2
	mflo $s1
    	li $t0,'0'  				# Tải giá trị kí tự '0' vào $t0
    	add $t0,$t0,$t2				# Chuyển đổi các số thành các kí tự số
	j set
	
point:		
	li $t0, '.'  				# Tải giá trị dấu '.' vào $t0
    						
set:   	
	add $t7,$a2,$s4
	sb $t0,($t7)  				#Lưu lần lượt các kí tự vào trong mảng chuỗi kết quả
	addi $s4,$s4,1				#Cộng 1 số chữu số
	beq $t1,$zero,less_than_1		#Nếu đã chia hết thì nhảy đến nhãn less_than_1 kiểm tra xém số có nhỏ hơn 0 hay không?
	j loop

less_than_1:
	bne $s6,1, sign				#Nếu số lớn hơn 1 thì thì nhảy đến nhãn sign kiểm tra dấu
	li $t0, '.'				#Thêm dấu chấm thập phân vào cuối mảng kết quả
	add $t7,$a2,$s4			
	sb $t0,($t7)
	add $s4,$s4,1				#Số kí tự +1
	li $t0, '0'				#Thêm số 0 vào cuối mảng kết quả
	add $t7,$a2,$s4
	sb $t0,($t7)
	addi $s4,$s4,1				#Số kí tự +1
	
sign:	
	bne $s2,1, print			#Nếu là số dương thì nhảy đến biến print
	li $t0, '-'				#Thêm dấu trừ vào cuối mảng
	add $t7,$a2,$s4
	sb $t0,($t7)
	addi $s4,$s4,1				#Số kí tự +1

print:
	
	#Do các chữ số sau khi chia sẽ bị đảo ngược lại, lúc này cần đảo ngược chuỗi kết quả
	divu $t0,$s4, 2		#n/2
	li  $t1,0 		#str[0]
	subi $t2,$s4,1		#str[n-1]
	li $t3,0     		#i=0

for:	
	beq $t3,$t0, endfor
	add $t7,$a2,$t1
	lb $t4,($t7)
	add $t7,$a2,$t2
	lb $t5,($t7)
	add $t7,$a2,$t1
	sb $t5,($t7)
	add $t7,$a2,$t2
	sb $t4,($t7)	
	addi $t1,$t1,1
	subi $t2,$t2,1				
	addi $t3,$t3,1
	j for
endfor:

	#Sau khi đảo ngược chuỗi kết quả ta được chuối kết quả của số cần làm tròn
	li $t0, '\0'
	add $t7,$a2,$s4	 #Thêm kí tự '\0' để tạo thành một chuội hoàn chỉnh
	sb $t0,($t7)
     	move $v1,$s4	#Gán số kí tự của chuỗi số vào v1 để sử dụng khi in vào file	
	
	jr $ra		#Quay về nơi gọi hàm











