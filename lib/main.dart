import 'dart:convert';
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

  void getChatBotReply(String userReply) async {
    _txtController.clear();
    var response = await http.get(Uri.parse(
        "http://api.brainshop.ai/get?bid=167356&key=e6tFkq6ZISxTtYXn&uid=[dp_25]&msg=[$userReply"));
    var data = jsonDecode(response.body);
    var botReply = data["cnt"];
    Message msg= Message(
      text: botReply,
      type: false,
    );
    setState(() {
      _msg.insert(0,msg);
    });

  }
  void handleSubmitted(text) async{
    _txtController.clear();
    Message msg= Message(
      text: text,
      type: true,
    );
    setState(() {
      _msg.insert(0, msg);
    });
    getChatBotReply(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Bot'),
      ),
      backgroundColor: Colors.grey[300],
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
  final bool type;
  const Message({
    required this.text,
    required this.type,
  });

  List<Widget> bot(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: const CircleAvatar(child: Text('Bot')),
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
            child: Text('You', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
          )
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
