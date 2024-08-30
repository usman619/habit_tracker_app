import 'package:flutter/material.dart';
import 'package:habit_tracker_app/themes/text_theme.dart';

class MyDrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const MyDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: drawerTextTheme(context),
      ),
      leading: Icon(
        icon,
        size: 24,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: () => onTap!(),
    );
  }
}
