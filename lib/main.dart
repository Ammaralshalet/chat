// ignore_for_file: library_private_types_in_public_api

import 'package:flurchat/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flurchat/model/chat_model.dart';
import 'package:flurchat/service/chat_service.dart';
import 'package:flurchat/view/chat_privat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int selectedPage = 2;
  late List<ChatModel> history = [];
  late List<ChatModel> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Messages',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
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
                child: const Icon(Icons.more_vert)),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Icon(Icons.edit_square),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 238, 241, 244),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              onChanged: (value) {
                result = [];
                for (var i = 0; i < history.length; i++) {
                  if (value.isEmpty) {
                    result = history;
                  } else {
                    if (history[i].name.contains(value)) {
                      result.add(history[i]);
                    }
                  }
                }
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: 'Search for chats & messages',
                hintStyle: TextStyle(
                  color: Color(0xff7D848D),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Icon(Icons.search, color: Color(0xff7D848D)),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<ChatModel>>(
                future: ChatServiceImp().getChat(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text(''));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text(''));
                  } else {
                    history = snapshot.data!;
                    result = result.isEmpty ? history : result;
                    return ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        Color containerColor;
                        Color readOfColor;

                        if (result[index].unreadMessageCount < 35) {
                          readOfColor = Colors.blue;
                        } else if (result[index].unreadMessageCount < 50) {
                          readOfColor = Colors.green;
                        } else {
                          readOfColor = Colors.grey;
                        }
                        if (result[index].unreadMessageCount < 35) {
                          containerColor = Colors.red;
                        } else if (result[index].unreadMessageCount < 50) {
                          containerColor = Colors.green;
                        } else {
                          containerColor = Colors.blue;
                        }
                        String stringDate =
                            result[index].date.substring(11, 16);

                        return InkWell(
                          child: ListTile(
                            title: Text(result[index].name),
                            subtitle: Row(
                              children: [
                                Text(result[index].message),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.done_all,
                                  color: readOfColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(stringDate),
                              ],
                            ),
                            leading: Stack(
                              children: [
                                Hero(
                                  tag: result[index].id,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(result[index].image),
                                  ),
                                ),
                                Positioned(
                                  left: 30,
                                  top: 31,
                                  child: Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: containerColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPrivet(
                                  chatModel: result[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: Colors.blue,
        backgroundColor: Colors.white,
        animationDuration: const Duration(seconds: 1),
        selectedIndex: selectedPage,
        onDestinationSelected: (value) {
          setState(() {
            if (value == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            } else if (value == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPrivet(
                    chatModel: result[0],
                  ),
                ),
              );
            }
            selectedPage = value;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.calendar_month,
            ),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calender',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.search,
            ),
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.message,
            ),
            icon: Icon(Icons.message_outlined),
            label: 'Messages',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person_2,
            ),
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
