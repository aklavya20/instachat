import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:instachat/Appwrite/AppwriteService.dart';
import 'package:instachat/Appwrite/Authentication.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      _currentUser = value;
      if (_currentUser == null || _currentUser?.emailVerification == false) {
        Navigator.pushReplacementNamed(context, '/verify');
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  static final List<Widget> _pages = <Widget>[
    Center(child: Text('Chats', style: TextStyle(fontSize: 24))),
    Center(child: Text('Broadcast', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('InstaChat'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logoutUser();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign_outlined),
            label: 'Broadcast',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
