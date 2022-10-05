import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ui_library/ui_library_export.dart';
import 'package:uplink/file/domain/item.dart';
import 'package:uplink/file/presentation/controller/item_list_bloc.dart';

class PhotoDetailPage extends StatefulWidget {
  const PhotoDetailPage({super.key, required this.item});

  final Item item;

  @override
  State<PhotoDetailPage> createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  final _itemListController = GetIt.I.get<ItemListBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar.back(title: widget.item.name),
      body: Center(child: Image.file(widget.item.file)),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomAppBar(
          color: UColors.backgroundDark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<ItemListBloc, ItemListState>(
                bloc: _itemListController,
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _itemListController
                            .add(SwitchFavoriteStatus(widget.item));
                      });
                    },
                    icon: UIcon(
                      UIcons.favorite,
                      color: widget.item.isFavorited
                          ? UColors.ctaBlue
                          : UColors.textMed,
                    ),
                  );
                },
              ),
              IconButton(
                onPressed: () {},
                icon: const UIcon(UIcons.edit),
              ),
              IconButton(
                onPressed: () {},
                icon: const UIcon(UIcons.download),
              ),
              IconButton(
                onPressed: () {},
                icon: const UIcon(UIcons.remove),
              )
            ],
          ),
        ),
      ),
    );
  }
}