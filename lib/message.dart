import 'package:flutter/material.dart';
import 'package:insighted2/main.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> messages = [
    Message(
        content:
            "Halo, dok. Saya merasa sangat cemas dan stress belakangan ini.",
        isUser: true),
    Message(
        content:
            "Halo! Terima kasih telah menghubungi saya. Saya mendengar bahwa Anda merasa cemas dan stres. Apakah Anda ingin berbicara lebih lanjut tentang apa yang membuat Anda merasa seperti itu?",
        isUser: false),
    Message(
        content: "Ya, saya sangat tertarik. Apa yang bisa saya lakukan?",
        isUser: true),
    Message(
        content:
            "Itu cukup umum ketika seseorang mengalami tingkat stres yang tinggi. Saya ingin mencoba beberapa teknik manajemen stres dengan Anda. Apakah Anda tertarik?",
        isUser: false),
    Message(
        content:
            "Ya, saya merasa sulit berkonsentrasi dan tidur nyenyak akhir-akhir ini. Saya juga merasa kehilangan minat pada hal-hal yang biasanya saya nikmati.",
        isUser: true),
    Message(
        content:
            "Saya ingin berbagi beberapa strategi yang mungkin membantu Anda mengelola rasa cemas Anda: \n- Bernapas dalam-dalam: Saat Anda merasa cemas, perhatikan napas Anda. \n- Tetap Aktif: Lakukan aktivitas fisik secara teratur. Berjalan kaki, berlari, atau menari.",
        isUser: false),
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Scroll to the bottom when the screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    // Ensure scroll only happens if there are messages
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => MyApp()));
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('asset/psikolog.jpg'),
          )
        ],
        title: Text('Dr. Tirta Mandira Hudhi',
            style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        messages.add(
                            Message(content: _controller.text, isUser: true));
                        _controller.clear();
                        // Scroll to bottom after adding a new message
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollToBottom();
                        });
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 290.0,
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(
          message.content,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

class Message {
  final String content;
  final bool isUser;

  Message({required this.content, required this.isUser});
}
