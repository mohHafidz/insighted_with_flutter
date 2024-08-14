import 'package:flutter/material.dart';
import 'package:insighted2/chat.dart';
import 'package:insighted2/home.dart';
import 'package:insighted2/home2.dart';
import 'package:insighted2/psikolog.dart';
import 'package:insighted2/soal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Initialize Firebase with your options
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'insightEd',
      home: SafeArea(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // Menyimpan indeks halaman yang aktif

  final List<Widget> _screens = [
    const Home2(),
    const Psikolog(),
    const Soal(),
    const Chat(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah indeks yang aktif
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      backgroundColor: const Color(0xFFF0F8FE),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    required this.currentIndex,
    required this.onItemTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/home.png'),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/vector.png'),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/major.png'),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/chat.png'),
          label: "",
        ),
      ],
      currentIndex: currentIndex, // Menyinkronkan indeks yang aktif
      onTap: onItemTapped, // Mengatur callback saat item diklik
    );
  }
}
