# JHAutoLayout
AutoLayout UI

如果下面的内容看不了，请移至：http://blog.csdn.net/xjh093/article/details/53501919

举个粟子：<br>
在控制器的view上面添加一个view。<br>
```objc
    UIView
    .jhView()
    .jh_addToView(self.view)
    .jh_frame(@"[x:10,y:80,w:2_w(0)-15,h:110]")
    .jh_bgColor(({
        UIColor *color = [UIColor lightGrayColor];
        color;
    })).jh_tag(@(100));
```
其中，jh_bgColor也可以传字符串：<br>
```objc
jh_bgColor(@"0xeeeeee");
```
或者直接是：<br>
```objc
jh_bgColor([UIColor brownColor])
```
当然，这个不是讨论的重点。重点是：jh_frame <br>
传参可以是：<br>
NSValue类型：[NSValue valueWithCGRect:CGRectMake(10,20,30,40)]; <br>
字符串类型：  <br>
1. @“{{10,20},{30,40}}”; <br>
2. @"[x:20,y:120,w:150,h:30]"


##重点来了！

重点讲字符串中的第2种类型：<br>
标准格式是：@"[x:value,y:value,w:value,h:value]"<br>
value就是重点讲解对象！

###value的类型：<br>
####1.常量<br>
相当于是绝对布局了，比如这种：@"[x:20,y:120,w:150,h:30]"

####2.变量
这就是相对布局了。

####2.1 W 与 H
W:屏幕的宽度。<br>
H:屏幕的高度。<br>
比如：@"[x:0,y:0,w:W,h:H]"<br>
就是一个铺满整个屏幕的View。

####2.2 W+(-*/)value
W加上，减去，乘以，除以一个值。<br>
比如：@"[x:0,y:0,w:W*0.5,h:H]"<br>
就是一个铺满左半边屏幕的View。

H,同理。

####2.3 prefix(value)
prefix可以是：x,y,w,h,midx,midy,maxx,maxy。<br>
value是：view的父类view的tag值，或者是父类view里面子view的tag值。<br>
比如：<br>
x(110) 表示取父类view中tag值为100的view的x值，即x(100) == view.frame.origin.x <br>
y(110) 表示取父类view中tag值为100的view的y值，即y(100) == view.frame.origin.y <br>
w(110) 表示取父类view中tag值为100的view的width值，即w(100) == view.frame.size.width <br>
h(110) 表示取父类view中tag值为100的view的height值，即h(100) == view.frame.size.height <br>
midx(110) 表示取父类view中tag值为100的view的x+width*0.5值，即midx(100) == CGRectGetMidX(view.frame) <br>
midy(110) 表示取父类view中tag值为100的view的y+height*0.5值，即midy(100) == CGRectGetMidY(view.frame) <br>
maxx(110) 表示取父类view中tag值为100的view的x+width值，即maxx(100) == CGRectGetMaxX(view.frame) <br>
maxy(110) 表示取父类view中tag值为100的view的y+height值，即maxy(100) == CGRectGetMaxY(view.frame) <br>

####2.4 结合2.2与2.3
把2.2中的 W+(-*/)value的W换成 prefix(value) <br>
即成：prefix(value1)+(-*/)value2 <br>
比如： <br>
w(110)+10，就是：view.frame.size.width + 10 <br>
w(110)-10，就是：view.frame.size.width - 10 <br>
w(110)*10，就是：view.frame.size.width * 10 <br>
w(110)/10，就是：view.frame.size.width / 10 <br>

####2.5 value1_value2
表示：value2/value1 <br>
value1是int类型，1，2，3，4...... <br>
value2是prefix(value) <br>
比如：<br>
2_w(110)+10，就是：view.frame.size.width/2 + 10 <br>
2_w(110)-10，就是：view.frame.size.width/2 - 10 <br>
2_w(110)*10，就是：view.frame.size.width/2 * 10 <br>
2_w(110)/10，就是：view.frame.size.width/2 / 10 <br>

结束！

开启自动布局：
```objc
[self.view jhAutoLayout];
```

更新布局：
```objc
-(void)viewDidAppear:(BOOL)animated  
{ 
      [super viewDidAppear:animated]; 
      [self.view jhUpdateLayout];  
} 
```
为什么要放在viewDidApper里面？

有可能从其他界面返回后，还是之前没有更新的布局。

比如：

VC1竖屏旋转成横屏后进入VC2，VC2横屏旋转成竖屏后再返回，就需要更新。

