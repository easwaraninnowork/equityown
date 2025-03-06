import 'package:flutter/material.dart';
import 'package:quityown/widgets/constants.dart';

class LanguageLayout extends StatelessWidget {
  const LanguageLayout({
    Key? key,
    required this.language,
    required this.onTap,
    required this.imageName,
  }) : super(key: key);
  final String language;
  final VoidCallback onTap;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border:  Border.all(color: Colors.grey),
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
                (states) => Colors.black12,
          ),
        ),
        onPressed: onTap,
        child:
            SingleChildScrollView(
              child: Column(
                children: [
                  Image(image: AssetImage(imageName),alignment: Alignment.center,width: 30,height: 30,),
                  SizedBox(height: 10,),
                  Text(language,style: blackHeadStyle,textAlign: TextAlign.center,),
                ],
              ),
            )
      ),
    );
  }
}
