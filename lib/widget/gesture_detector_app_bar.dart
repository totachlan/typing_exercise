import 'package:flutter/material.dart';

class GestureDetectorAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onTap;
  final AppBar appBar;

  const GestureDetectorAppBar({
    Key? key,
    required this.onTap,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: appBar,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
