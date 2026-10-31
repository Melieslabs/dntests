import 'package:dartnative/dartnative.dart';

import 'app_widgets.dart';
import 'chat_data.dart';

class _Channel {
  final String id;
  final String name;
  final String followers;
  final String initials;
  final List<Color> colors;

  const _Channel(this.id, this.name, this.followers, this.initials, this.colors);
}

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  static const Color _muted = Color(0x99FFFFFF);
  static const Color _accent = Color(0xFFFF8A3D);

  final Set<String> _seen = {'5', '6'};
  final Set<String> _following = {};

  final List<String> _times = const [
    '4 minutes ago',
    '28 minutes ago',
    '1 hour ago',
    'Today, 07:50',
    'Yesterday, 22:14',
    'Yesterday, 19:03',
  ];

  final List<_Channel> _channels = const [
    _Channel('c1', 'Tech Daily', '82K followers', 'TD', [Color(0xFF8AA0C7), Color(0xFF3F4F73)]),
    _Channel('c2', 'Campus News', '14K followers', 'CN', [Color(0xFF9CC7A4), Color(0xFF4F7A5A)]),
    _Channel('c3', 'Afrobeats Weekly', '210K followers', 'AW', [Color(0xFFC79ABB), Color(0xFF734060)]),
  ];

  void _markSeen(Chat chat) => setState(() => _seen.add(chat.id));

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: _muted,
        ),
      ),
    );
  }

  Widget _myStatus() {
    return Column(
      children: [
        SizedBox(
          width: 66,
          height: 66,
          child: Stack(
            children: [
              const Avatar(
                initials: 'KD',
                colors: [Color(0xFFE6D5C8), Color(0xFF9C8272)],
                size: 66,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: _accent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: const Icon(Icons.add, size: 14, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const SizedBox(
          width: 70,
          child: Text(
            'My status',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _storyTile(Chat chat) {
    return GestureDetector(
      onTap: () => _markSeen(chat),
      child: Column(
        children: [
          Avatar(
            initials: chat.initials,
            colors: chat.colors,
            size: 66,
            ring: true,
            ringSeen: _seen.contains(chat.id),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 70,
            child: Text(
              chat.name.split(' ').first,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _storiesRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _myStatus(),
          for (final chat in mockChats)
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: _storyTile(chat),
            ),
        ],
      ),
    );
  }

  Widget _updateRow(Chat chat, String time) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _markSeen(chat),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Avatar(
              initials: chat.initials,
              colors: chat.colors,
              size: 54,
              ring: true,
              ringSeen: _seen.contains(chat.id),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 13, color: _muted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _channelCard(_Channel channel) {
    final following = _following.contains(channel.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF161312),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Avatar(initials: channel.initials, colors: channel.colors, size: 46),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  channel.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  channel.followers,
                  style: const TextStyle(fontSize: 12, color: _muted),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() {
              if (following) {
                _following.remove(channel.id);
              } else {
                _following.add(channel.id);
              }
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: following ? const Color(0x26FFFFFF) : _accent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                following ? 'Following' : 'Follow',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: following ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    final items = <Widget>[
      const Text(
        'Updates',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 16),
      _storiesRow(),
      const SizedBox(height: 24),
      _sectionLabel('Recent updates'),
      for (var i = 0; i < mockChats.length; i++) _updateRow(mockChats[i], _times[i]),
      const SizedBox(height: 24),
      _sectionLabel('Channels'),
      for (final channel in _channels) _channelCard(channel),
    ];

    return ScreenBackground(
      child: FastList(
        itemCount: items.length,
        padding: EdgeInsets.fromLTRB(20, top + 12, 20, 120),
        itemBuilder: (context, index) => items[index],
      ),
    );
  }
}