import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
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
        // 更改ui风格
        theme: new ThemeData(
          primaryColor: Colors.white,
        ),
        home: new RandomWords());
  }
}

// 添加 RandomWordsState 类,随机单词的方法
class RandomWordsState extends State<RandomWords> {
  // _suggestions列表以保存建议的单词对,该变量以下划线（_）开头，在Dart语言中使用下划线前缀标识符，会强制其变成私有的

  final _suggestions = <WordPair>[];

  // biggerFont变量来增大字体大小
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // 这个集合存储用户喜欢（收藏）的单词对。
  final _saved = new Set<WordPair>();

  // 新页面的内容在在MaterialPageRoute的builder属性中构建，builder是一个匿名函数
  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final titles = _saved.map((pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });

      // 添加生成ListTile行的代码。ListTile的divideTiles()方法在每个ListTile之间添加1像素的分割线。 该 divided 变量持有最终的列表项。
      final divided =
          ListTile.divideTiles(context: context, tiles: titles).toList();

      // builder返回一个Scaffold，其中包含名为“Saved Suggestions”的新路由的应用栏。 新路由的body由包含ListTiles行的ListView组成; 每行之间通过一个分隔线分隔
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Save Suggesttions'),
        ),
        body: new ListView(
          children: divided,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Startup App',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
      // 在偶数行，该函数会为单词对添加一个ListTile row.
      // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
      // 注意，在小屏幕上，分割线看起来可能比较吃力。
      itemBuilder: (context, i) {
        // 在每一列之前，添加一个1像素高的分隔线widget
        if (i.isOdd) {
          return new Divider();
        }
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
        final index = i ~/ 2;

        // 如果是建议列表中最后一个单词对
        if (index >= _suggestions.length) {
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    //  添加一个心形 ❤️ 图标到 ListTiles以启用收藏功能
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // 在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，从而导致对UI的更新
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

// /**
//  * 有状态的类
//  */
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordsState();
  }
}
