import 'package:dartnative/dartnative.dart';

import 'app_widgets.dart';
import 'glass_panel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color _cardColor = Color(0xFF161312);
  static const Color _muted = Color(0x99FFFFFF);
  // static const Color _accent = Color(0xFFFF8A3D);

  bool _locked = false;

  Widget _topBar() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: GlassPanel(
            radius: BorderRadius.circular(20),
            interactive: true,
            width: 40,
            height: 40,
            child: const Center(
              child: Icon(Icons.more_vert, size: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Avatar(
            initials: 'ML',
            colors: [Color(0xFFE6D5C8), Color(0xFF9C8272)],
            size: 92,
            online: true,
          ),
          SizedBox(height: 12),
          Text(
            'Melies Labs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '+12-6541-1234',
            style: TextStyle(fontSize: 13, color: _muted),
          ),
          SizedBox(height: 6),
          Text(
            'Available',
            style: TextStyle(fontSize: 13, color: Color(0xFF34C759)),
          ),
        ],
      ),
    );
  }

  Widget _editButton() {
    return GestureDetector(
      onTap: () {},
      child: GlassPanel(
        radius: BorderRadius.circular(22),
        height: 44,
        interactive: true,
        child: const Center(
          child: Text(
            'Edit profile',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0x1FFFFFFF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, color: _muted)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statsPanel() {
    return GlassPanel(
      radius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            _stat('Chats', '128'),
            const SizedBox(width: 4),
            _stat('Groups', '14'),
            const SizedBox(width: 4),
            _stat('Calls', '342'),
          ],
        ),
      ),
    );
  }

  Widget _mediaTile(List<Color> colors, {String? overlay}) {
    return Expanded(
      child: Container(
        height: 84,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: overlay == null
              ? const Icon(Icons.image_outlined, size: 20, color: Color(0x66FFFFFF))
              : Text(
                  overlay,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _mediaCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1916),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Media, links and docs',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, size: 18, color: _muted),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Row(
              children: [
                _mediaTile(const [Color(0xFFE0A06A), Color(0xFF3B2A24)]),
                const SizedBox(width: 2),
                _mediaTile(const [Color(0xFF8C6B4F), Color(0xFF2B2018)]),
                const SizedBox(width: 2),
                _mediaTile(const [Color(0xFF6E8A5B), Color(0xFF1D2A1B)]),
                const SizedBox(width: 2),
                _mediaTile(const [Color(0xFF8A8F8C), Color(0xFF2A2C2B)], overlay: '+42'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String label, {Widget? trailing, Color color = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: color),
            ),
          ),
          trailing ?? const Icon(Icons.chevron_right, size: 18, color: _muted),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.only(left: 50),
      color: const Color(0x14FFFFFF),
    );
  }

  Widget _settingsCard(List<Widget> rows) {
    final children = <Widget>[];
    for (var i = 0; i < rows.length; i++) {
      if (i > 0) children.add(_divider());
      children.add(rows[i]);
    }

    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    final items = <Widget>[
      _topBar(),
      const SizedBox(height: 16),
      _header(),
      const SizedBox(height: 18),
      _editButton(),
      const SizedBox(height: 16),
      _statsPanel(),
      const SizedBox(height: 12),
      _mediaCard(),
      const SizedBox(height: 12),
      _settingsCard([
        _row(Icons.notifications_none, 'Notifications'),
        _row(Icons.star_border, 'Starred messages'),
        _row(Icons.bookmark_border, 'Saved'),
        _row(Icons.devices, 'Linked devices'),
      ]),
      const SizedBox(height: 12),
      _settingsCard([
        _row(
          Icons.lock_outline,
          'Lock chats',
          trailing: Switch(
            value: _locked,
            activeTrackColor: const Color(0xFF34C759),
            onChanged: (value) => setState(() => _locked = value),
          ),
        ),
        _row(Icons.shield_outlined, 'Privacy'),
        _row(Icons.data_usage, 'Storage and data'),
        _row(Icons.help_outline, 'Help'),
      ]),
      const SizedBox(height: 12),
      _settingsCard([
        _row(Icons.logout, 'Log out', trailing: const SizedBox(), color: const Color(0xFFFF453A)),
      ]),
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