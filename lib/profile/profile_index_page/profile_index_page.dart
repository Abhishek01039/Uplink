import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ui_library/ui_library_export.dart';
import 'package:uplink/l10n/main_app_strings.dart';
import 'package:uplink/utils/ui_utils/qr_code_bottom_sheet.dart';

part 'models/body.part.dart';
part 'models/edit_profile_body.dart';
part 'models/network_profiles_body.part.dart';
part 'models/profile_data_body.part.dart';

class ProfileIndexPage extends StatefulWidget {
  const ProfileIndexPage({Key? key}) : super(key: key);

  @override
  State<ProfileIndexPage> createState() => _ProfileIndexPageState();
}

class _ProfileIndexPageState extends State<ProfileIndexPage> {
  final _badgesQuantity = 5;
  final _coverPicturePath =
      'packages/ui_library/images/placeholders/cover_photo_1.png';
  bool _isEditingProfile = false;
  final _duration = const Duration(milliseconds: 250);

  final usernameTextFieldController = TextEditingController();
  final statusMessageTextFieldController = TextEditingController();
  final locationTextFieldController = TextEditingController();
  final aboutTextFieldController = TextEditingController();

  String? userImagePath;

  File? _imageFile;

  void _verifyIfHasImage() {
    if (_imageFile != null && _imageFile!.path.isNotEmpty) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                UAppBar.actions(
                  title: '',
                  leading: _isEditingProfile
                      ? IconButton(
                          icon: const UIcon(
                            UIcons.back_arrow_button,
                            color: UColors.white,
                          ),
                          onPressed: () async {
                            setState(() {
                              _isEditingProfile = false;
                            });
                          },
                        )
                      : const SizedBox(),
                  actionList: [
                    if (!_isEditingProfile) ...[
                      IconButton(
                        icon: const UIcon(
                          UIcons.qr_code,
                          color: UColors.white,
                        ),
                        onPressed: () {
                          qrCodeBottomSheet(context, userImagePath).show();
                        },
                      ),
                      IconButton(
                        icon: const UIcon(
                          UIcons.hamburger_menu,
                          color: UColors.white,
                        ),
                        onPressed: () {},
                      ),
                    ] else
                      IconButton(
                        icon: const UIcon(
                          UIcons.compose_message_button,
                          color: UColors.white,
                        ),
                        onPressed: () {
                          UBottomSheetTwoButtons(
                            context,
                            header:
                                UAppStrings.profileIndexPage_bannerPhotoHeader,
                            firstButtonText: UAppStrings
                                .profileIndexPage_bannerPhotoFirstButtonText,
                            secondButtonText: UAppStrings
                                .profileIndexPage_bannerPhotoSecondButtonText,
                            firstButtonIcon: UIcons.camera,
                            secondButtonIcon: UIcons.image,
                            firstButtonOnPressed: () async {
                              _imageFile = await UImagePicker(
                                shouldShowPermissionDialog: true,
                              ).pickImageFromCamera(
                                context,
                                uCropStyle: UCropStyle.rectangle,
                                uCropAspectRatio: UCropAspectRatio(
                                  ratioX: _size.width,
                                  ratioY: 164,
                                ),
                              );
                              _verifyIfHasImage();
                              setState(() {});
                            },
                            secondButtonOnPressed: () async {
                              _imageFile =
                                  await UImagePicker().pickImageFromGallery(
                                context,
                                uCropStyle: UCropStyle.rectangle,
                                uCropAspectRatio: UCropAspectRatio(
                                  ratioX: _size.width,
                                  ratioY: 164,
                                ),
                              );
                              _verifyIfHasImage();
                              setState(() {});
                            },
                          ).show();
                        },
                      ),
                  ],
                  flexibleSpace: SizedBox(
                    height: 164,
                    width: double.infinity,
                    child: _imageFile != null
                        ? Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            _coverPicturePath,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const SizedBox.square(
                        dimension: 114,
                      ),
                      UUserPictureChange(
                        showChangeImageButton: _isEditingProfile,
                        onPictureSelected: (value) {
                          userImagePath = value?.path;
                        },
                      ),
                      AnimatedCrossFade(
                        duration: _duration,
                        firstChild: _ProfileIndexBody(
                          badgesQuantity: _badgesQuantity,
                          pageSize: _size,
                          onTapEditProfile: (value) {
                            setState(() {
                              _isEditingProfile = value;
                            });
                          },
                        ),
                        secondChild: _EditProfileBody(
                          usernameTextFieldController:
                              usernameTextFieldController,
                          statusMessageTextFieldController:
                              statusMessageTextFieldController,
                          locationTextFieldController:
                              locationTextFieldController,
                          aboutTextFieldController: aboutTextFieldController,
                        ),
                        crossFadeState: _isEditingProfile
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
