import 'package:flurchat/model/chat_model.dart';
import 'package:flutter/material.dart';

class ChatPrivet extends StatelessWidget {
  final ChatModel chatModel;

  const ChatPrivet({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    String stringDate = chatModel.date.substring(11, 16);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: chatModel.id,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(chatModel.image),
                ),
              ),
            ),
            Center(
              child: Text(
                chatModel.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 238, 241, 244),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.call),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 235, 244, 235),
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(chatModel.name),
                    subtitle: Text(chatModel.message),
                    trailing: Text(stringDate),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  height: 40,
                  width: 250,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 241, 244),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Type you message',
                      hintStyle: TextStyle(
                        color: Color(0xff7D848D),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      suffixIcon:
                          Icon(Icons.attach_file, color: Color(0xff7D848D)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(Icons.mic),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
