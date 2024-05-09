import 'package:flutter/material.dart';

class ImageWithReflection extends StatelessWidget {
  const ImageWithReflection({
    Key? key,
    required this.imageURL,
    required this.cardHeight,
  }) : super(key: key);

  final String imageURL;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      child: Column(
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            child: Image(
              image: AssetImage(imageURL),
              height: cardHeight / 2,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: cardHeight / 2,
            child: Transform.flip(
              flipY: true,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                // ignore: avoid_unnecessary_containers
                child: Image(
                  image: AssetImage(imageURL),
                  height: cardHeight / 2,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
