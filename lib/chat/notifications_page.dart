import 'package:flutter/material.dart';
import 'package:ui_library/ui_library_export.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    Key? key,
    required this.uNotificationsList,
  }) : super(key: key);

  final List<UNotification> uNotificationsList;

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar.back(
        title: 'Notifications',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: UNotificationsList(
            uNotificationList: widget.uNotificationsList,
          ),
        ),
      ),
    );
  }
}
