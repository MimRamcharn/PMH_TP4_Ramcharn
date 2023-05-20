import 'package:flutter/material.dart';
import 'package:tp4_task2/database.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _queryResult = [];

  _insertData() async {
    int id = await DatabaseHelper.instance
        .insert({DatabaseHelper.columnName: _controller.text});
    print('Inserted row id: $id');
  }

  _queryData() async {
    List<Map<String, dynamic>> queryResult =
        await DatabaseHelper.instance.queryAllRows();
    setState(() {
      _queryResult = queryResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Name',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _insertData,
            child: Text('Insert Data'),
          ),
          ElevatedButton(
            onPressed: _queryData,
            child: Text('Query Data'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _queryResult.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text(
                      _queryResult[index][DatabaseHelper.columnId].toString()),
                  title: Text(_queryResult[index][DatabaseHelper.columnName]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
