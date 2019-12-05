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
	# 因子 Factor :分类依据 因子就是不重复的向量中元素
		# nlevels给出因子个数
		apple_colors <- c('green','green','yellow','red','red','red','green')
		factor_apple <- factor(apple_colors)
		print(factor_apple)
		print(nlevels(factor_apple))

		[1] green  green  yellow red    red    red    yellow green 
		Levels: green red yellow
		[1] 3

	# 时间序列 Time series :按时间顺序排列的数据
	# 矩阵 Matrix :二维数组
		M = matrix( c('a','a','b','c','b','a'), nrow = 2, ncol = 3, byrow = TRUE)
		print(M)

			[,1] [,2] [,3]
		[1,] "a"  "a"  "b" 
		[2,] "c"  "b"  "a"

	# 数组 Array :多维有序数组
		a <- array(c('green','yellow'),dim = c(3,3,2))
		print(a)

	# 列表 List :可以包含任何类型数据，数组，表或函数
		> {
		+   n1<-c("周一","周二","周三","周四","周五")
		+   n2<-c("第一节","第二节","第三节","第四节")
		+   l1<-list(n2,n1)
		+   print(l1)
		+   list1 <- list(c(2,5,3),21.3,sin)
		+   print(list1)
		+ }
		[[1]]
		[1] "第一节" "第二节" "第三节" "第四节"
		
		[[2]]
		[1] "周一" "周二" "周三" "周四" "周五"
		
		[[1]]
		[1] 2 5 3
		
		[[2]]
		[1] 21.3
		
		[[3]]
		function (x)  .Primitive("sin")

	# 数据框 Data frame :特殊列表，之后常用的数据结构，必须等长（和表格类似）
		BMI <- 	data.frame(
		   gender = c("Male", "Male","Female"), 
		   height = c(152, 171.5, 165), 
		   weight = c(81,93, 78),
		   Age = c(42,38,26)
		)
		print(BMI)

		  gender height weight Age
		1   Male  152.0     81  42
		2   Male  171.5     93  38
		3 Female  165.0     78  26  
# 变量
	# 命名规则：字母/点开头，点开头不能跟数字，中间可以有下划线

	# 变量可以被重复初始化为不同类型

	# print(ls()) 列出所有变量

	# 使用rm()删除变量，rm(list=ls())删除所有变量

# 运算符 操作符对向量的每个元素起作用
	# %%表示求余 %/%表示相除取整数部分

	# 关系运算符结果为布尔类型

	# 按位逻辑运算符，不为0的值都视为逻辑真（所有元依次进行运算）
	# &&和||只取向量的第一个元素进行运算

	# ：，冒号运算符，生成按顺序的向量
	# %in%,标识元素是否属于向量
		v1 <- 8
		v2 <- 12
		t <- 1:10
		print(v1 %in% t) 	TRUE
		print(v2 %in% t) 	FALSE
	# %*%，用于矩阵和其转置相乘

# 包
	# 获取R包的库位置 .libPaths()
	# 获取安装的包列表 library()
	# 获取在当前R环境中加载的包 search()
	# 安装一个包  install.packages("Package Name")

# 循环
	# Repeat循环
		repeat { 
		   commands #循环的内容
		   if(condition) {	#终止条件
		      break
		   }
		}
	# while循环
		while (test_expression) {
		   statement
		}
	#for循环		可用来遍历向量元素
		for (test_expression) {
		   statement
		}
		eg:
		v <- LETTERS[1:4]
		for ( i in v) {
		   print(i)
		}
	#循环控制中break和c语言相同，next和continue相同

# 数据重塑
 	# cbind()可以连接向量创建数据框，rbind()可以合并另个数据框
 	city<-c("Tampa","Seattle","Hartford","Denver")
 	state<-c("FL","WA","CT","CO")
 	zipcode<-c(33602,98104,06161,80294)
 	addresses<-cbind(city,state,zipcode)

	     city       state zipcode
	[1,] "Tampa"    "FL"  "33602"
	[2,] "Seattle"  "WA"  "98104"
	[3,] "Hartford" "CT"   "6161" 
	[4,] "Denver"   "CO"  "80294"

	newad<-data.frame(city,state,zipcode)

	      city state zipcode
	1    Tampa    FL   33602
	2  Seattle    WA   98104
	3 Hartford    CT    6161
	4   Denver    CO   80294

	all.adress<-rbind(addresses,newad)
	print(all.adress)

	      city state zipcode
	1    Tampa    FL   33602
	2  Seattle    WA   98104
	3 Hartford    CT    6161
	4   Denver    CO   80294
	5    Tampa    FL   33602
	6  Seattle    WA   98104
	7 Hartford    CT    6161
	8   Denver    CO   80294
	cat("# # # The combined data frame") # 对比输出的不同
	# # # The combined data frame
	print("# # # The combined data frame")
#	[1] "# # # The combined data frame"
	
	# merge()函数合并数据框，根据条件，相同的只显示一次,内部也合并
	library(MASS)
	merge.Pima<- merge(x=Pima.te,y=Pima.tr,
		by.x=c("bp","bmi"),
		by.y=c("bp","bmi")
	)
	print(merge.Pima)
	nrow(merge.Pima)

	# melt()拆分数据进行重组，