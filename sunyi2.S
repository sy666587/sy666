.eqv Result1, 0x50001000
.section .data
my_buffer: .space 200 #分配200字节的地址
.section .text 
la a0, my_buffer #将buffer的地址加载到a0

.global main
main:

#初始化
li t0, 1#判断的对象
li s2, 201
mv s1, a0#复制地址到s1

loop1:
    li t1, 2
    beq t0, t1, shizhishu       # 2是质数
    li t3, 2
    bge t0, t3, check_even      # 只有大于等于2的数才可能是质数
    j bushizhishu               # 1不是质数

check_even:
div t4, t0, t1
mul t5, t4, t1
beq t5, t0, bushizhishu

#然后判断是否能被对应的奇数整除
li t2, 3
li t3, 17 #循环上限
loop2:
beq t0, t2, shizhishu
div t4, t0, t2
mul t5, t4, t2
beq t5, t0, bushizhishu
addi t2, t2, 2
blt t2, t3, loop2

j shizhishu #无条件跳转到是质数

shizhishu:
li t5, 1
sb t5, 0(s1)#结果存入内存地址
j next_number

bushizhishu:
li t5, 0
sb t5, 0(s1) #结果存入内存地址

next_number:
addi s1, s1, 1              # 内存地址的自增
addi t0, t0, 1              # t0的自增
blt t0, s2, loop1           # 继续循环

end:
j end