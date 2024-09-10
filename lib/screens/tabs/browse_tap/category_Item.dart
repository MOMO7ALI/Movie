import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/generated/assets.dart';

class Categoryitem extends StatelessWidget {
  const Categoryitem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Image.asset(Assets.imagesFantasy,width: double.infinity,height: double.infinity,fit: BoxFit.cover,)),
        Text(
          "asdasd",
          style: TextStyle(fontSize: 20 , color: Colors.blueAccent),
        ),
      ],
    );
  }
}
