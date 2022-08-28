### 通信相关

nrf的SPI采用指令+读取返回值的形式
第一次不管发什么都会回答STATUS状态寄存器的值，之后返回指令相关的内容
![image.png](pic/communicate.png)
