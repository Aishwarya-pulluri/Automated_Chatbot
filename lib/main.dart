
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<Message> _msg = <Message>[];
  final TextEditingController _txtController = TextEditingController();
  void getChatbotReply(String userReply) async {
    _txtController.clear();
    var response = await http.get(Uri.parse(
        "http://api.brainshop.ai/get?bid=167355&key=CbtBJcCmY96vzXjL&uid=[Aishwarya pulluri]&msg=[$userReply]"));
    var data = jsonDecode(response.body);
    var botReply = data["cnt"];
    Message msg= Message(
      text: botReply,
      name: "Bot",
      type: false,
    );
    setState(() {
      _msg.insert(0,msg);
    });

  }
  void handleSubmitted(text) async{
    if (kDebugMode) {
      print(text);
    }
    _txtController.clear();
    Message msg= Message(
      text: text,
      name: "YOU",
      type: true,
      //date: DateTime.now(),
    );
    setState(() {
      _msg.insert(0, msg);
    });
    getChatbotReply(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Bot'),
      ),
      backgroundColor: Colors.cyan[100],
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all( 8.0),
                reverse: true,
                itemBuilder: (_, int index) => _msg[index],
                itemCount: _msg.length,
              )
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).cardColor),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                //color: Colors.grey[300],
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _txtController,
                        onSubmitted: handleSubmitted,
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Send a message'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () => handleSubmitted( _txtController.text),
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ) ,
        ],
      ),
    );
  }
}
class Message extends StatelessWidget {
  final String text;
  final String name;
  final bool type;
  // final DateTime date;
  // ignore: use_key_in_widget_constructors
  const Message({
    required this.text,
    required this.name,
    required this.type,
    //  required this.date,
  });

  List<Widget> bot(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: const CircleAvatar(child: Text('B')),
      ),
      Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(text, style: const TextStyle(fontSize: 20.0)),
              )
            ],
          )
      )
    ];
  }
  List<Widget> me(context) {
    return <Widget>[

      Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                //color: Colors.white,
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(text, style: const TextStyle(fontSize: 20.0)),
              )
            ],
          )
      ),
      Container(
          margin: const EdgeInsets.only(left: 16.0),
          child: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text('U', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: type ? me(context) : bot(context),
        )
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
