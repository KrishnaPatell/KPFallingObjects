# KPFallingObjects
KPFallingObjects displays falling effect of custom images on your UIView like falling snow, numbers, alphabets etc...


### Screenshots
![](https://github.com/KrishnaPatell/KPFallingObjects/blob/master/KPFallingObjects/Demo1.gif)
![](https://github.com/KrishnaPatell/KPFallingObjects/blob/master/KPFallingObjects/Demo2.gif)

![](https://github.com/KrishnaPatell/KPFallingObjects/blob/master/KPFallingObjects/Demo3.gif)
![](https://github.com/KrishnaPatell/KPFallingObjects/blob/master/KPFallingObjects/Demo4.gif)

### Installation
Simply include KPFallingObjectView.h and KPFallingObject.m file into your project directory.


### Usage

Simply import KPFallingObjectView.h file in your controller.

```sh
#import KPFallingObjectView.h
```

And then Write the following code in your UIViewController's .m file.

```sh
KPFallingObjectView *obj = [[KPFallingObjectView alloc] initWithFrame:_viewContainer.frame];
obj.arrFlakeFileName = [[NSMutableArray alloc] initWithObjects:@"0.png", @"1.png", @"4.png", @"6.png", @"8.png", nil];
[_viewContainer addSubview:obj];
[obj beginFallAnimation];
```
You can pass custom images in to arrFlakeFileName.
You can also manage flakesCount, flakesWidth, flakesheight, minimum and maximum duration of animation.

#### Methods

There are two methods that starts and stops falling images.

```sh
- (void)beginFallAnimation;
- (void)endFallAnimation;
```

## Requirements
iOS 7.0+

## License
MIT License



