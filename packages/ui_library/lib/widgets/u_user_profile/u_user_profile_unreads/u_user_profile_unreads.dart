import 'package:flutter/material.dart';

import '../../../core/core_export.dart';
import '../../u_text/u_text_export.dart';
import '../models/models_export.dart';

part 'models/clipper.dart';
part 'models/messages_unreads.dart';

/// Creates an User Profile Unreads Widget
class UUserProfileUnreads extends StatelessWidget {
  /// Creates User Profile Unreads Widget without name
  ///
  /// [imagePath] if null, it will assume a default placeholder
  const UUserProfileUnreads({
    Key? key,
    String? imagePath,
    required int messagesUnreads,
  })  : _imagePath = imagePath,
        _userProfileType = UUserProfileType.noUsername,
        _userProfileUsername = null,
        _uUserProfileSize = UUserProfileSize.normal,
        _messagesUnreads = messagesUnreads,
        super(key: key);

  /// Creates User Profile Unreads Widget with name
  ///
  /// [imagePath] if null, it will assume a default placeholder
  const UUserProfileUnreads.withUsername({
    Key? key,
    String? imagePath,
    required String username,
    required int messagesUnreads,
  })  : _imagePath = imagePath,
        _userProfileUsername = username,
        _userProfileType = UUserProfileType.withUsername,
        _uUserProfileSize = UUserProfileSize.normal,
        _messagesUnreads = messagesUnreads,
        super(key: key);

  final UUserProfileSize _uUserProfileSize;

  final UUserProfileType _userProfileType;

  final int _messagesUnreads;

  final String? _userProfileUsername;

  final String? _imagePath;

  @override
  Widget build(BuildContext context) {
    final _messagesUnreadsIndicator = MessagesUnreadsIndicator(
      messagesUnreads: _messagesUnreads,
    );
    final _correctPositionNotification = _uUserProfileSize.size -
        (USizes.userProfileMessagesUnreadsIndicatorSize);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: _messagesUnreads > 999
              ? USizes.userProfileMessagesUnreadsMaxMessagesSize
              : null,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: ClipPath(
                  clipper: UserProfileUnreadsClipper(_messagesUnreads),
                  child: SizedBox(
                    height: _uUserProfileSize.size,
                    width: _uUserProfileSize.size,
                    child: _imagePath != null
                        ? Image.network(_imagePath!)
                        : Image.asset(
                            'packages/ui_library/images/placeholders/user_avatar_2.png',
                          ),
                  ),
                ),
              ),
              Positioned(
                top: _correctPositionNotification,
                right: 0,
                child: _messagesUnreadsIndicator,
              ),
            ],
          ),
        ),
        if (_userProfileType == UUserProfileType.withUsername) ...[
          const SizedBox.square(dimension: 8),
          SizedBox(
            width: USizes.userProfileNormalMaxUsernameTextSize,
            child: UText(
              _userProfileUsername!,
              textOverflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
              textStyle: UTextStyle.M1_micro,
            ),
          ),
        ]
      ],
    );
  }
}
