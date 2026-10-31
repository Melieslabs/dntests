import 'package:dartnative/dartnative.dart';

class Message {
  final String text;
  final bool mine;
  final String time;

  const Message(this.text, {required this.mine, required this.time});
}

class Chat {
  final String id;
  final String name;
  final String initials;
  final String preview;
  final String time;
  final int unread;
  final bool online;
  final List<Color> colors;
  final List<Message> messages;

  const Chat({
    required this.id,
    required this.name,
    required this.initials,
    required this.preview,
    required this.time,
    required this.colors,
    required this.messages,
    this.unread = 0,
    this.online = false,
  });
}

const List<Chat> mockChats = [
  Chat(
    id: '1',
    name: 'Ada Okafor',
    initials: 'AO',
    preview: 'Sending the Figma link now',
    time: '11:42',
    unread: 3,
    online: true,
    colors: [Color(0xFFE6D5C8), Color(0xFF9C8272)],
    messages: [
      Message('Hey, did you see the new design?', mine: false, time: '11:30'),
      Message('Not yet, send it over', mine: true, time: '11:35'),
      Message('Sending the Figma link now', mine: false, time: '11:42'),
    ],
  ),
  Chat(
    id: '2',
    name: 'Chidi Nwosu',
    initials: 'CN',
    preview: 'Standup moved to 10am',
    time: '10:15',
    unread: 1,
    colors: [Color(0xFF9CC7A4), Color(0xFF4F7A5A)],
    messages: [
      Message('Standup moved to 10am', mine: false, time: '10:15'),
    ],
  ),
  Chat(
    id: '3',
    name: 'Mum',
    initials: 'M',
    preview: 'Call me when you are free',
    time: 'Yesterday',
    online: true,
    colors: [Color(0xFFE0A06A), Color(0xFF8C5A2E)],
    messages: [
      Message('Have you eaten?', mine: false, time: '18:02'),
      Message('Yes mum, just finished', mine: true, time: '18:10'),
      Message('Call me when you are free', mine: false, time: '18:11'),
    ],
  ),
  Chat(
    id: '4',
    name: 'Dev Group',
    initials: 'DG',
    preview: 'Tobi: the build is green',
    time: 'Yesterday',
    unread: 12,
    colors: [Color(0xFF8AA0C7), Color(0xFF3F4F73)],
    messages: [
      Message('Tobi: pushed the fix', mine: false, time: '16:40'),
      Message('Tobi: the build is green', mine: false, time: '16:52'),
    ],
  ),
  Chat(
    id: '5',
    name: 'Ngozi',
    initials: 'N',
    preview: 'See you at the library',
    time: 'Mon',
    colors: [Color(0xFFC79ABB), Color(0xFF734060)],
    messages: [
      Message('See you at the library', mine: false, time: '09:20'),
    ],
  ),
  Chat(
    id: '6',
    name: 'Emeka',
    initials: 'E',
    preview: 'Thanks for the notes',
    time: 'Sun',
    colors: [Color(0xFFB8B8B8), Color(0xFF5A5A5A)],
    messages: [
      Message('Thanks for the notes', mine: false, time: '21:05'),
    ],
  ),
];