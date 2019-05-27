# R语言学习笔记.R

# R中的任何对象都具有属性，内在属性：mode length  mode是数据类型，常见有数值，逻辑，复数，字符
#						 其他属性：dim class    dim是维度
	> {
	+   v <-TRUE 
	+   print(class(v))
	+   v <- 23.5
	+   print(class(v))
	+   v <- 2L
	+   print(class(v))
	+   v <- 2+5i
	+   print(class(v))
	+   v <- "TRUE"
	+   print(class(v))
	+   
	+ }
	[1] "logical"	#逻辑
	[1] "numeric"	#数值
	[1] "integer"	#整数
	[1] "complex"	#复数
	[1] "character"	#字符

# 数据对象的类型 class
	# 向量 Vector :有序数据,数据类型相同
		f<-c(1,2,3,4)
		x<-1:10      #间隔为1的数组
		str<-c("hello","world")
		# Create a vector.
		apple <- c('red','green',"yellow")
		print(apple)
		# Get the class of the vector.
		print(class(apple))
	# 因子 Factor :分类依据
	# 时间序列 Time series :按时间顺序排列的数据
	# 矩阵 Matrix :二维数组
	# 数组 Array :多维有序数组
	# 列表 List :可以包含任何类型数据
		n1<-c("周一","周二","周三","周四","周五")
		n2<-c("第一节","第二节","第三节","第四节")
		l1<-list(n2,n1)
		list1 <- list(c(2,5,3),21.3,sin)
	print(list1)

	# 数据框 Data frame :特殊列表，最强数据结构