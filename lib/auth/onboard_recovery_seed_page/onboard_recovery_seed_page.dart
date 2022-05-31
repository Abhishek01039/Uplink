// ignore_for_file: lines_longer_than_80_chars, unused_local_variable

import 'package:flutter/material.dart';
import 'package:ui_library/ui_library_export.dart';
import 'package:ui_library/widgets/u_dialog/u_dialog_export.dart';
import 'package:uplink/auth/auth_export.dart';
import 'package:uplink/l10n/main_app_strings.dart';

part 'models/recovery_seed_boxes_part.dart';
part 'models/screenshot_recovery_seed_boxes_part.dart';

class OnboardRecoverySeedPage extends StatefulWidget {
  const OnboardRecoverySeedPage({Key? key}) : super(key: key);

  @override
  State<OnboardRecoverySeedPage> createState() =>
      _OnboardRecoverySeedPageState();
}

class _OnboardRecoverySeedPageState extends State<OnboardRecoverySeedPage> {
  bool _isRecoverySeedWordsSaved = false;
  final _isLoading = ValueNotifier(false);

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UActionLoading(
      dashLoadingIndicatorPadding: const EdgeInsets.only(left: 48),
      isLoading: _isLoading,
      child: Scaffold(
        appBar: UAppBar.back(title: UAppStrings.recoverySeedPage_appBarTitle),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: ListView(
              children: [
                const UText(
                  UAppStrings.recoverySeedPage_pageDescription,
                  textStyle: UTextStyle.B1_body,
                ),
                const SizedBox(height: 24),
                const _RecoverySeedBoxes(),
                const SizedBox(height: 48),
                UButton.primary(
                  label: UAppStrings.recoverySeedPage_iSavedItButton,
                  uIconData: UIcons.checkmark_rounded,
                  onPressed: () {
                    if (!_isRecoverySeedWordsSaved) {
                      UBottomSheetTwoButtons(
                        context,
                        firstButtonOnPressed: () {
                          Navigator.pop(context);
                        },
                        secondButtonOnPressed: () {
                          Navigator.of(context)
                            ..pop()
                            ..push(
                              MaterialPageRoute<void>(
                                builder: (context) =>
                                    const OnboardPrivacySettingFirstPage(),
                              ),
                            );
                        },
                        header: UAppStrings
                            .recoverySeedPage_areYouSureBottomSheetHeader,
                        firstButtonText: UAppStrings.goBackButton,
                        secondButtonText: UAppStrings.continueButton,
                      ).show();
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              const OnboardPrivacySettingFirstPage(),
                        ),
                      );
                    }
                  },
                ),
                UButton.secondary(
                  label: UAppStrings.recoverySeedPage_screenshotButton,
                  uIconData: UIcons.camera,
                  onPressed: () async {
                    _isLoading.value = true;

                    final _uScreenShot = UScreenShot();
                    final _uSaveImageOnGallery = USaveImageOnGallery();

                    final _image = await _uScreenShot.captureFromWidget(
                      context,
                      widget: const _ScreenShotRecoverySeedBoxes(),
                    );

                    _isLoading.value = false;
                    if (!mounted) return;
                    await UBottomSheetTwoButtons(
                      context,
                      header: UAppStrings
                          .recoverySeedPage_screenshotCapturedBottomSheetHeader,
                      firstButtonText: UAppStrings.cancelButton,
                      firstButtonOnPressed: () {
                        Navigator.pop(context);
                      },
                      secondButtonText: UAppStrings.agreeButton,
                      secondButtonOnPressed: () async {
                        await _uSaveImageOnGallery
                            .saveImage(
                          context,
                          _image,
                          imageNameToSave:
                              UAppStrings.recoverySeedPage_imageNameToSave,
                        )
                            .then((value) async {
                          _isRecoverySeedWordsSaved = value;
                          Navigator.pop(context);
                          if (_isRecoverySeedWordsSaved) {
                            await _savedScreenShotDialog(context)
                                .showUDialog<UDialog>();
                          }
                        });
                      },
                    ).show();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  UDialog _savedScreenShotDialog(BuildContext context) {
    return UDialog(
      context,
      title: UAppStrings.recoverySeedPage_uDialogTitle,
      actions: [],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const UText(
            UAppStrings.recoverySeedPage_uDialogDescription,
            textStyle: UTextStyle.B1_body,
          ),
          const SizedBox.square(
            dimension: 16,
          ),
          Row(
            children: [
              Expanded(
                child: UButton.filled1(
                  label: UAppStrings.recoverySeedPage_uDialogOk,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
