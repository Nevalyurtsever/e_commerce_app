import 'dart:io';

import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatelessWidget {
  final Function callbackImage;
  CustomImagePicker({super.key, required this.callbackImage});
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.localizations!.choose_a_method_to_add_photos,
              style: context.theme.appTextTheme.subtitleStyle,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              try {
                XFile? picketImage =
                    await _picker.pickImage(source: ImageSource.camera);
                if (picketImage != null) {
                  callbackImage(File(picketImage.path));
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            child: Text(context.localizations!.camera),
          ),
          const SizedBox(height: 50)
        ],
      );
    }

    return CupertinoActionSheet(
      title: Text(context.localizations!.choose_a_method_to_add_photos),
      actions: <CupertinoActionSheetAction>[
        if (Platform.isAndroid || Platform.isIOS)
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              try {
                XFile? picketImage =
                    await _picker.pickImage(source: ImageSource.camera);
                if (picketImage != null) {
                  callbackImage(File(picketImage.path));
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            child: Text(context.localizations!.camera),
          ),
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.pop(context);
            try {
              XFile? pickedImage =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (pickedImage != null) {
                callbackImage(File(pickedImage.path));
              }
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          child: Text(context.localizations!.gallery),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        child: Text(context.localizations!.cancel),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
