import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_library/ui_library_export.dart';
import 'package:ui_library/widgets/bottom_sheet/bottom_sheet_template.dart';
import 'package:uplink/contacts/models/contact_list_tile.dart';
import 'package:uplink/contacts/models/data/mock_contact.dart';
import 'package:uplink/contacts/models/search/show_custom_search.dart';

class ContactSearch extends SearchCustomDelegate<MockContact?> {
  ContactSearch(
    this.loadContactsList,
  );

  final Future<List<MockContact>> loadContactsList;

  @override
  String get searchFieldLabel => 'Search Contacts...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    if (context.read<ThemeModel>().getThemeType == ThemeMode.dark) {
      return Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(color: UColors.backgroundDark),
      );
    }
    return context.read<ThemeModel>().getThemeData;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const UIcon(UIcons.back_arrow_button),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return const [SizedBox(width: 16)];
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSuggestions();
  }

  FutureBuilder<List<MockContact>> _buildSuggestions() {
    return FutureBuilder(
      future: loadContactsList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final contactsList = snapshot.data!;

          //show suggestion when user typed the first letter
          if (contactsList.isEmpty || query.isEmpty) {
            return const SizedBox();
          } else {
            final suggestions = contactsList.where(
              (element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()),
            );

            return ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestionList = suggestions.toList();
                final item = suggestionList[index];
                return ContactListTile(
                  name: item.name,
                  statusMessage: item.statusMessage,
                  status: item.status,
                  onTap: () {
                    // TODO(yijing): update to user profile page
                    UBottomSheet(
                      context,
                      child: Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: double.infinity,
                        child: Text(item.name),
                      ),
                    ).show();
                  },
                );
              },
            );
          }
        }
        return const Center(child: ULoadingIndicator());
      },
    );
  }
}