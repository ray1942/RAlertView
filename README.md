# RAlertView
RAlertView --- 弹窗
前几天写了菊花，后来发现还缺个弹窗，于是乎写了简单的弹窗。到目前为止，项目中遇到的弹窗还没有要求说有输入框的，所以写了个简简单单的弹窗。代码放到github了，RAlertView --- 弹窗 https://github.com/ray1942/RAlertView

显示效果有多种：成功(默认)／错误／警告／详情／自定义图标

* 成功(默认)



![成功](http://upload-images.jianshu.io/upload_images/3243621-2152bf846cc5507a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 错误

![错误](http://upload-images.jianshu.io/upload_images/3243621-1848623b5418145d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* 警告

![警告](http://upload-images.jianshu.io/upload_images/3243621-03db62aa10bf4f28.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 详情


![详情提示](http://upload-images.jianshu.io/upload_images/3243621-7e8be63655367477.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 #使用方法
*使用初始化方法
```
//默认显示
RAlertView.init(title: String, detailText: String, cancelTitle: String)

//如果修改显示样式
RAlertView.init(title: String, detailText: String, cancelTitle: String, style: RAlertStyle)

//如果需要完成后处理点事情
RAlertView.init(title: String, detailText: String, cancelTitle: String, style: RAlertStyle, completClosure: (()->())?)

//如果需要添加多个按钮 需要设置delegate
 RAlertView.init(title: String, detailText: String, cancelTitle: String, style: RAlertStyle, delegate: RAlertViewDelegate?, otherTitles: Array<String>?, completClosure: (() -> ())?)

```
* 显示样式
```
//弹窗样式
enum RAlertStyle: Int {
    case Success,Error,Warning,Info,Custom,Default;
}
```
* 设置滑入屏幕的模式
```
//滑入样式
enum RAlertModel: Int{
    case Fade,Top,Bottom,Left,Right;
}

alert.enterModel = .Left
alert.leavaModel = .Right
```
* 显示
```
alert.show()
```
* 多个按钮时实现代理方法
```
extension XXViewController: RAlertViewDelegate{
    func alertView(alertView: RAlertView, didClickIndex: Int) {
        print(didClickIndex)
    }
}
```
封装完这个弹窗用Instruments测试了下Demo发现有内存泄漏问题，经过研究添加了alertDestroy方式来完成弹窗的扫尾工作。
