import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategorieCard extends StatelessWidget {
  final int index;
  final String path;
  final String titre;

  const CategorieCard({
    super.key,
    required this.index,
    required this.path,
    required this.titre,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (kDebugMode) {
          print(index);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(path), //this is the background image
                fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 79, 56, 18),
                Colors.white.withOpacity(0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [
                0,
                0.5,
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                titre,
                style: const TextStyle(
                    fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
