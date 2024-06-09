import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final String imagePath;
  const FullScreenImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: imagePath,
            child: PhotoView(
              imageProvider: NetworkImage(imagePath),
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.only(left: 3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x1e000000),
              ),
              child: const BackButton(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
