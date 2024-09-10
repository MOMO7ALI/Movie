import 'package:flutter/material.dart';
import 'package:movies_app/screens/tabs/browse_tap/category_Item.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Browse Category",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            SizedBox(height: 18,),
            Expanded(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing:40 ,
                  mainAxisSpacing: 40 ,
                childAspectRatio: 1.5
              ),
                itemBuilder: (context, index) {

                  return Container(
                      height: 12,
                      width: 60,
                      child: Categoryitem());
                  },
                itemCount: 10
              ),
            )
          ],
        ),
      )),
    );
  }
}
