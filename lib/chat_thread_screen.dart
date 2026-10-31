import 'package:dartnative/dartnative.dart';

import 'app_widgets.dart';
import 'chat_data.dart';
import 'glass_panel.dart';

class ChatThreadScreen extends StatefulWidget {
  final Chat chat;

  const ChatThreadScreen({super.key, required this.chat});

  @override
  State<ChatThreadScreen> createState() => _ChatThreadScreenState();
}

class _ChatThreadScreenState extends State<ChatThreadScreen> {
  static const Color _muted = Color(0x99FFFFFF);
  static const Color _accent = Color(0xFFFF8A3D);

  late final List<Message> _messages = List.of(widget.chat.messages);
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;
  bool _typing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    setState(() {
      _messages.add(Message(text, mine: true, time: 'now'));
      _hasText = false;
      _typing = true;
    });
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!context.mounted) return;
      setState(() {
        _typing = false;
        _messages.add(Message('Got it, give me a minute', mine: false, time: 'now'));
      });
    });
  }

  Widget _title() {
    final chat = widget.chat;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Avatar(initials: chat.initials, colors: chat.colors, size: 36),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              chat.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              _typing ? 'typing...' : (chat.online ? 'Online' : 'Offline'),
              style: TextStyle(
                fontSize: 12,
                color: _typing || chat.online ? const Color(0xFF34C759) : _muted,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dateChip(String label) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0x26FFFFFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, color: _muted),
        ),
      ),
    );
  }

  Widget _bubble(Message message) {
    final maxWidth = MediaQuery.sizeOf(context).width * 0.76;
    final mine = message.mine;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Row(
        mainAxisAlignment: mine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 9, 12, 6),
              decoration: BoxDecoration(
                color: mine ? null : const Color(0xFF2A2321),
                gradient: mine
                    ? const LinearGradient(
                        colors: [Color(0xFFFFA25C), Color(0xFFFF7A1F)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(mine ? 18 : 5),
                  bottomRight: Radius.circular(mine ? 5 : 18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 15,
                      color: mine ? Colors.black : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message.time,
                        style: TextStyle(
                          fontSize: 10,
                          color: mine ? const Color(0x99000000) : _muted,
                        ),
                      ),
                      if (mine) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.done_all, size: 13, color: Color(0x99000000)),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _typingBubble() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2321),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              '• • •',
              style: TextStyle(fontSize: 14, color: _muted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputBar() {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(12, 8, 12, bottom > 0 ? bottom : 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: GlassPanel(
              radius: BorderRadius.circular(22),
              interactive: true,
              width: 44,
              height: 44,
              child: const Center(
                child: Icon(Icons.add, size: 22, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GlassPanel(
              radius: BorderRadius.circular(22),
              height: 44,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                          onChanged: (value) {
                            final has = value.trim().isNotEmpty;
                            if (has != _hasText) setState(() => _hasText = has);
                          },
                          onSubmitted: (_) => _send(),
                          decoration: const InputDecoration(
                            hintText: 'Message',
                            hintStyle: TextStyle(color: _muted),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _hasText ? _send : () {},
            child: Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _hasText ? _accent : const Color(0x33FFFFFF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  _hasText ? Icons.arrow_upward_rounded : Icons.mic_none,
                  size: 22,
                  color: _hasText ? Colors.black : Colors.white,
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
    final reversed = _messages.reversed.toList();
    final items = <Widget>[
      if (_typing) _typingBubble(),
      for (final message in reversed) _bubble(message),
      _dateChip('Today'),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      brightness: Brightness.dark,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        title: _title(),
        actions: [
          BarButtonItem(fontIcon: CupertinoIcons.videocam, onPressed: () {}),
          BarButtonItem(fontIcon: CupertinoIcons.phone, onPressed: () {}),
        ],
      ),
      body: ScreenBackground(
        child: FastList(
          itemCount: items.length,
          reverse: true,
          padding: EdgeInsets.fromLTRB(0, top + 70, 0, 10),
          itemBuilder: (context, index) => items[index],
        ),
      ),
      bottomInputBar: _inputBar(),
    );
  }
}