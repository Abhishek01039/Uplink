import 'package:flutter/material.dart';
import 'package:ui_library/ui_library_export.dart';
import 'package:uplink/l10n/main_app_strings.dart';

class ChatIndexPage extends StatefulWidget {
  const ChatIndexPage({Key? key}) : super(key: key);

  @override
  State<ChatIndexPage> createState() => _ChatIndexPageState();
}

class _ChatIndexPageState extends State<ChatIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar.actions(
        actionList: [
          IconButton(
            icon: const UIcon(
              UIcons.search,
              color: UColors.textMed,
            ),
            onPressed: () async {},
          ),
          IconButton(
            icon: const UIcon(
              UIcons.menu_bar_notifications,
              color: UColors.textMed,
            ),
            onPressed: () async {},
          ),
          IconButton(
            icon: const UIcon(
              UIcons.compose_message_button,
              color: UColors.textMed,
            ),
            onPressed: () async {},
          ),
        ],
        leading: IconButton(
          icon: const UIcon(
            UIcons.lefthand_navigation_drawer,
            color: UColors.textMed,
          ),
          onPressed: () async {},
        ),
        title: UAppStrings.chatIndexPage_appBarTitle,
      ),
      body: const SafeArea(
        child: Text(''),
      ),
    );
  }
}
