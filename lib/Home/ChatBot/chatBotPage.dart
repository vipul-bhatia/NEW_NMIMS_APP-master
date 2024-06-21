import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class chatBotPage extends StatefulWidget {
   const chatBotPage({Key? key}) : super(key: key);

  @override
  State<chatBotPage> createState() => _chatBotPageState();
}

class _chatBotPageState extends State<chatBotPage> {
  final myController = TextEditingController();
  List<String> chatMessages = [];

  void _sendMessage() async {
    String message = myController.text;
    var response = await http.post(
      
      Uri.parse('https://chatbot-kfhs.onrender.com/predict'), // Replace with your API endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': message,
      }),
    );

    setState(() {
      chatMessages.insert(0, message);
      chatMessages.insert(0, jsonDecode(response.body)['language']); // Assuming API returns a JSON object with a 'message' field
    });

    myController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatMessages[index]),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: "Enter message",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ),
              onSubmitted: (value) => _sendMessage(),
            ),
          ),
        ],
      ),
    );
  }
}