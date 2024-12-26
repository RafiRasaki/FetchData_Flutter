import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../models/game.dart';

class ItemGame extends StatelessWidget {
  const ItemGame({
    super.key,
    required this.game, 
    required this.onSaveClick,
  });

  final Game game;
  final VoidCallback onSaveClick;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ExtendedImage.network(
            game.thumbnail!,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment(0, -0.5),
                colors: [
                  Colors.black,
                  Colors.transparent,
              ],),
            ),
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(4),
            child: Text(
            game.title?? "",
            style: TextStyle(
              color: Colors.white,
            ),
            ),
           ),
        ),
         Positioned(
          top: 4,
          right: 4,
          child: IconButton.filledTonal(
            onPressed: onSaveClick, 
          icon: game.isSaved
          ? const Icon(Icons.bookmark, color:Colors.blue,) 
          : const Icon (Icons.bookmark_border, color: Colors.grey,)
          ),
         )             
      ],
    );
  }
}