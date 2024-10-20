import 'package:flutter/material.dart';

class CustomAppbarOrderManagement extends StatelessWidget
    implements PreferredSizeWidget {
  final int orderCount;
  final double badgeSize;
  final Widget financialScreen;

  const CustomAppbarOrderManagement({
    Key? key,
    required this.orderCount,
    required this.badgeSize,
    required this.financialScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Text(''),
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: const Text(
        'Orders Management',
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.orange,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
