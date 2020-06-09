# 今年流行的拟态Neumorphism与常见的集中阴影形式

[DEMO地址:https://github.com/yuezaixz/DwShadowDemo](https://github.com/yuezaixz/DwShadowDemo)

最近应用中用到的阴影比较多，加上自己独立开发的应用也尝试了今年流行的拟态Neumorphism设计，所以稍微研究了下常见的集中阴影在设计和开发实现上形式。

## iOS的阴影API

### shadowColor

自定义阴影的颜色。默认颜色是UIColor.black.cgColor，它会产生深色阴影，但您也可以设置浅色以创建发光效果，或其他任何颜色。

### shadowOpacity

自定义阴影的不透明度，介于0和1之间。值为0表示阴影将不可见。

### shadowRadius

自定义阴影的模糊度。0表示阴影完全不会模糊。

### shadowOffset

从视图中自定义阴影的位置。如果要向界面添加深度，此属性特别有用。 CGSize.zero值表示阴影将与其父视图完美对齐。默认为-3，在iOS上表现是向上偏移3个点，在macOS上是向下偏移，应该是因为macOS的原因，正常感觉，阴影应该是在下方的，因为现实世界中，很少光源处于低视角。

### shadowPath

自定义阴影的形状。此属性的默认值为nil，这意味着UIKit将自行确定父视图的形状。
不设置shadowPath会实时计算阴影，这会是一个非常消耗资源的，尤其是图层有多个子图层，每个图层还有一个有透明效果的寄宿图的时候。
因此，如果形状是可控的话，尽量设置他。

## 阴影的常见形式

### 拟态Neumorphism

竟然今天这篇文章因他而起，就先说他吧。
拟态是今年比较火的一种设计形式，dribble和一些个人应用开发上比较常见。商业应用由于风格统一问题，暂时应该还很难看到。
[有兴趣了解的话，可以看看这篇文章](https://uxdesign.cc/neumorphism-in-user-interfaces-b47cef3bf3a6)

个人开发应用中，我已经尝试起这种形式了。

![](http://image.runmaf.com/2020-06-10-15917206259996.jpg)

其实他的原理就是两段式的阴影组合，左侧和上侧用暗色阴影，右侧和下侧用亮色阴影，组合其他就是一个凹陷的效果。反之，就是一个凸出的效果。

### 正面投影（光源较远）

正面投影应该是最经典阴影了，也是最常见的阴影。通过从View的Bounds创建UIBezierPath来为此基本阴影指定路径，加上偏移、模糊、颜色等，就快速实现了阴影。

![](http://image.runmaf.com/2020-06-10-15917209241272.jpg)

```

imageView.layer.shadowRadius = 10
imageView.layer.shadowOffset = .zero
imageView.layer.shadowOpacity = 0.5
imageView.layer.shadowColor = UIColor.black.cgColor
imageView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
imageView.layer.masksToBounds = false

```

### 高处投影

当光源在高处试物体产生投影。产生的阴影是一个椭圆形。这种阴影很像太阳光使各种物体产生的阴影效果。

![](http://image.runmaf.com/2020-06-10-15917212274721.jpg)

``` swift

// 阴影的厚度
let size: CGFloat = 20
// 阴影在下方的距离
let distance: CGFloat = 80
let rect = CGRect(
    x: -size,
    y: imageView.frame.height - (size * 0.4) + distance,
    width: imageView.frame.width + size * 2,
    height: size
)

imageView.layer.shadowColor = UIColor.black.cgColor
imageView.layer.shadowRadius = 7
imageView.layer.shadowOpacity = 0.5
imageView.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
imageView.layer.masksToBounds = false

```

### 正面阴影（较近且可以水平移动光源）

当光源在你正面或背面，且可以水平移动，那么就会产生以后正面或背面的投影。有点像晚上在马路上，远处路灯产生的投影效果。

![](http://image.runmaf.com/2020-06-10-15917214247257.jpg)


```

// height 负数，光源在正面，阴影绘制在背影。正数，光源在背面，阴影绘制在前影
let scale = CGSize(width: 0.8, height: -0.6)
// 光源水平位置
let offsetX: CGFloat = 100

let shadowPath = UIBezierPath()
shadowPath.move(to:
    CGPoint(
        x: 0,
        y: imageView.frame.height
    )
)
shadowPath.addLine(to:
    CGPoint(
        x: imageView.frame.width,
        y: imageView.frame.height
    )
)
shadowPath.addLine(to:
    CGPoint(
        x: imageView.frame.width * scale.width + offsetX,
        y: imageView.frame.height * (1 + scale.height)
    )
)
shadowPath.addLine(to:
    CGPoint(
        x: imageView.frame.width * (1 - scale.width) + offsetX,
        y: imageView.frame.height * (1 + scale.height)
    )
)
imageView.layer.shadowColor = UIColor.black.cgColor
imageView.layer.shadowRadius = 7
imageView.layer.shadowOpacity = 0.5
imageView.layer.shadowPath = shadowPath.cgPath
imageView.layer.masksToBounds = false

```

### 弧形阴影

弧形阴影算我比较喜欢的阴影效果之一了。一是圆滑的曲线显得不会那么生硬，然后整体立体感也比较好。
可以调节弧度和模糊度来让弧度更明显，不过我觉得自然点更重要。

![](http://image.runmaf.com/2020-06-10-15917217072946.jpg)


``` swift

// 曲形阴影的曲度
let curve: CGFloat = 15

let shadowPath = UIBezierPath()
shadowPath.move(to: CGPoint.zero)
shadowPath.addLine(to: CGPoint(
    x: imageView.frame.width,
    y: 0
))
shadowPath.addLine(to: CGPoint(
    x: imageView.frame.width,
    y: imageView.frame.height + curve
))
shadowPath.addCurve(
    to: CGPoint(
        x: 0,
        y: imageView.frame.height + curve
    ),
    controlPoint1: CGPoint(
        x: imageView.frame.width,
        y: imageView.frame.height
    ),
    controlPoint2: CGPoint(
        x: 0,
        y: imageView.frame.height
    )
)
imageView.layer.shadowPath = shadowPath.cgPath
imageView.layer.shadowRadius = 10
imageView.layer.shadowOffset = CGSize(width: 0, height: 10)
imageView.layer.shadowOpacity = 0.5
imageView.layer.shadowColor = UIColor.black.cgColor
imageView.layer.masksToBounds = false

```

### 扁平阴影

这种阴影用的很少，简单看看效果带过吧。

![](http://image.runmaf.com/2020-06-10-15917216653737.jpg)


``` swift

let scale = CGSize(width: 1.5, height: 1.5)
let offset = CGPoint(x: imageView.frame.width, y: -imageView.frame.height)

let shadowPath = UIBezierPath()
shadowPath.move(to:
    CGPoint(
        x: 0,
        y: imageView.frame.height + (copysign(1, scale.height) * copysign(1, offset.x) == 1 ? 0 : offset.y)
    )
)
shadowPath.addLine(to:
    CGPoint(
        x: imageView.frame.width,
        y: imageView.frame.height + (copysign(1, scale.height) * copysign(1, offset.x) == -1 ? 0 : offset.y)
    )
)
shadowPath.addLine(to:
    CGPoint(
        x: imageView.frame.width * scale.width + offset.x,
        y: imageView.frame.height * (1 + scale.height) + offset.y
    )
)
shadowPath.addLine(to:
    CGPoint(
        x: imageView.frame.width * (1 - scale.width) + offset.x,
        y: imageView.frame.height * (1 + scale.height) + offset.y
    )
)
imageView.layer.shadowPath = shadowPath.cgPath
imageView.layer.shadowRadius = 0
imageView.layer.shadowOffset = .zero
imageView.layer.shadowOpacity = 0.2
imageView.layer.shadowColor = UIColor.black.cgColor
imageView.layer.masksToBounds = false

```


