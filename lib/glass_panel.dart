import 'package:dartnative/dartnative.dart';

class GlassPanel extends StatelessWidget {
  final BorderRadius radius;
  final bool interactive;
  final Color fill;
  final double? width;
  final double? height;
  final Widget child;

  const GlassPanel({
    super.key,
    required this.radius,
    required this.child,
    this.interactive = false,
    this.fill = const Color(0x33000000),
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GlassEffectContainer(
      borderRadius: radius,
      interactive: interactive,
      brightness: Brightness.dark,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: fill, borderRadius: radius),
        child: child,
      ),
    );
  }
}