import 'package:flutter/material.dart';
/**
 * StatefulWidget ： 具有可变状态的窗口部件，也就是你在使用应用的时候就可以随时变化，比如我们常见的进度条，随着进度不断变化。
  StatelessWidget：不可变状态窗口部件，也就是你在使用时不可以改变，比如固定的文字（写上后就在那里了，死也不会变了）。
  这个HelloWorld代码就继承了不可变窗口部件StatelessWidget。
 */

//主函数（入口函数），下面我会简单说说Dart的函数函数体里只有一行代码，所以可以直接使用=>来省略{}，只有函数体里只有一行时，才可以使用，否则请使用大括号

void main() => runApp(MyApp());

// 声明MyApp类
class MyApp extends StatelessWidget {
  //重写build方法
  @override
  Widget build(BuildContext context) {
    //返回一个Material风格的组件
    return MaterialApp(
      title: '66666',
      home: Scaffold(
        //创建一个Bar，并添加文本
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),

        //在主体的中间区域，添加一个hello world 的文本
        body:Center(
          child:Text('Hello dddd World'),
        ),
      ),
    );
  }
}
