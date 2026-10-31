import 'package:dartnative/dartnative.dart';
import 'package:glass_profile/chat_screen.dart';

import 'calls_screen.dart';
import 'profile_screen.dart';
import 'updates_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;
  String _query = '';

  Widget _placeholder(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 17, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      brightness: Brightness.dark,
      extendBody: true,
      body: IndexedStack(
        index: _tab,
        children: [
          const ChatsScreen(),
          const CallsScreen(),
          const UpdatesScreen(),
          const ProfileScreen(),
          _placeholder(_query.isEmpty ? 'Search' : 'Results for "$_query"'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (index) => setState(() => _tab = index),
        onSearchQueryChanged: (query) => setState(() => _query = query),
        scrollBehavior: TabBarScrollBehavior.minimizeOnScrollDown,
        iconColor: const Color(0xFF8E8E93),
        selectedIconColor: Colors.white,
        labelFontStyle: const TextStyle(color: Color(0xFF8E8E93)),
        selectedLabelFontStyle: const TextStyle(color: Colors.white),
        items: [
          BottomNavigationBarItem(
            label: 'Chats',
            icon: Icon(CupertinoIcons.chat_bubble),
          ),
          BottomNavigationBarItem(
            label: 'Call',
            icon: Icon(CupertinoIcons.phone),
          ),
          BottomNavigationBarItem(
            label: 'Updates',
            icon: Icon(CupertinoIcons.circle),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(CupertinoIcons.person),
          ),
          BottomNavigationBarItem.search(),
        ],
      ),
    );
  }
}