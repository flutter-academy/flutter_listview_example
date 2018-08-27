import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  log.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.loggerName}: ${rec.time}: ${rec.message}');
  });
  runApp(new MyApp());
}

final Logger log = new Logger('ListView');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter ListView',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new DynamicListView(),
    );
  }
}

List<Widget> _generate(int num) {
  return List.generate(num, (index) => _generateItem(index));
}

Widget _generateItem(int index) {
  log.info('Generate item $index');
  return new Container(
    padding: const EdgeInsets.all(8.0),
    child: new Row(
      children: <Widget>[
        new Image.network(
          'http://via.placeholder.com/200x100?text=Item$index',
          width: 200.0,
          height: 100.0,
        ),
        new Expanded(child: new Text('Item $index'))
      ],
    ),
  );
}

class StaticListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Static ListView')),
      body: new ListView(
        children: _generate(100),
      ),
    );
  }
}

class DynamicListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Dynamic ListView')),
      body: new ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) =>
              _generateItem(index)),
    );
  }
}
