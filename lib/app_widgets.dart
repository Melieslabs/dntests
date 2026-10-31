import 'package:dartnative/dartnative.dart';

class Avatar extends StatelessWidget {
  final String initials;
  final List<Color> colors;
  final double size;
  final bool online;
  final bool ring;
  final bool ringSeen;

  const Avatar({
    super.key,
    required this.initials,
    required this.colors,
    this.size = 52,
    this.online = false,
    this.ring = false,
    this.ringSeen = false,
  });

  Widget _core(double diameter) {
    return Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Text(
        initials,
        style: TextStyle(
          fontSize: diameter * 0.34,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF2A1E19),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget body = ring
        ? Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: ringSeen
                    ? const [Color(0x55FFFFFF), Color(0x55FFFFFF)]
                    : const [Color(0xFFFFB36B), Color(0xFFFF6A00)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Container(
              width: size - 6,
              height: size - 6,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: _core(size - 12),
            ),
          )
        : _core(size);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          body,
          if (online)
            Positioned(
              right: 1,
              bottom: 1,
              child: Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  color: const Color(0xFF34C759),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ScreenBackground extends StatelessWidget {
  final Widget child;

  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4A3A31),
            Color(0xFF1E1612),
            Color(0xFF000000),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}