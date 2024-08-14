import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insighted2/message.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFF0F8FE),
      body: Body(),
    ));
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Membership',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 57,
            width: 370,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(17)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none, // Menghilangkan border default
                      hintText: 'Search',
                    ),
                  ),
                ),
                Icon(Icons.search),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Psikolog',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
              child: ListView(
            children: [
              ListChat(),
              // ListChat(),
            ],
          ))
        ],
      ),
    );
  }
}

class ListChat extends StatelessWidget {
  const ListChat({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Fluttertoast.showToast(msg: 'click');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatScreen()));
        // Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              height: 82,
              width: 108,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(71)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(71),
                child: Image.asset(
                  'assets/psikolog.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Shindy Claudya Aprianti',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Dokter Umum',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
