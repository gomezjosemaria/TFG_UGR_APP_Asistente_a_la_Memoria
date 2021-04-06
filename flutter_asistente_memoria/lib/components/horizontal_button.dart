import 'package:flutter/material.dart';

class HorizontalButton extends StatelessWidget {

  final String text;
  final Function pressed;

  const HorizontalButton({Key key, this.text, this.pressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder()
        ),
        onPressed: pressed,
        child: Text(
          text
        )
      )
    );
  }
  
}