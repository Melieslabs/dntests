import 'package:dartnative/dartnative.dart';

import 'app_widgets.dart';
import 'chat_data.dart';
import 'glass_panel.dart';

enum CallKind { incoming, outgoing, missed }

class CallEntry {
  final Chat chat;
  final CallKind kind;
  final String when;
  final bool video;

  const CallEntry(this.chat, this.kind, this.when, {this.video = false});
}

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  static const Color _muted = Color(0x99FFFFFF);
  static const Color _accent = Color(0xFFFF8A3D);
  static const Color _missed = Color(0xFFFF453A);

  final List<CallEntry> _calls = [
    CallEntry(mockChats[0], CallKind.missed, 'Today, 11:20', video: true),
    CallEntry(mockChats[2], CallKind.incoming, 'Today, 09:05'),
    CallEntry(mockChats[1], CallKind.outgoing, 'Yesterday, 18:40'),
    CallEntry(mockChats[3], CallKind.incoming, 'Yesterday, 14:12', video: true),
    CallEntry(mockChats[4], CallKind.missed, 'Monday, 20:31'),
    CallEntry(mockChats[2], CallKind.outgoing, 'Monday, 08:48'),
    CallEntry(mockChats[5], CallKind.incoming, 'Sunday, 19:02'),
  ];

  int _filter = 0;

  IconData _kindIcon(CallKind kind) {
    switch (kind) {
      case CallKind.incoming:
        return Icons.call_received;
      case CallKind.outgoing:
        return Icons.call_made;
      case CallKind.missed:
        return Icons.call_missed;
    }
  }

  Widget _newCallCard() {
    return GestureDetector(
      onTap: () {},
      child: GlassPanel(
        radius: BorderRadius.circular(18),
        height: 60,
        interactive: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: _accent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(CupertinoIcons.phone_fill, size: 18, color: Colors.black),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'New call',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, size: 20, color: _muted),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calls',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: SegmentedControl(
            segments: const ['All', 'Missed'],
            selectedIndex: _filter,
            onValueChanged: (index) => setState(() => _filter = index),
            indicatorColor: const Color(0xFF3A302B),
            backgroundColor: const Color(0xFF1C1715),
            labelFontStyle: const TextStyle(fontSize: 13, color: Color(0xFF8E8E93)),
            selectedLabelFontStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _newCallCard(),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _row(CallEntry call) {
    final missed = call.kind == CallKind.missed;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Avatar(initials: call.chat.initials, colors: call.chat.colors, size: 50),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  call.chat.name,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: missed ? _missed : Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      _kindIcon(call.kind),
                      size: 14,
                      color: missed ? _missed : _muted,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      call.when,
                      style: const TextStyle(fontSize: 13, color: _muted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                call.video ? CupertinoIcons.videocam : CupertinoIcons.phone,
                size: 22,
                color: _accent,
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
    final visible = _filter == 0
        ? _calls
        : _calls.where((call) => call.kind == CallKind.missed).toList();

    return ScreenBackground(
      child: FastList(
        itemCount: visible.length + 1,
        padding: EdgeInsets.fromLTRB(20, top + 12, 20, 120),
        itemBuilder: (context, index) {
          if (index == 0) return _header();
          return _row(visible[index - 1]);
        },
      ),
    );
  }
}