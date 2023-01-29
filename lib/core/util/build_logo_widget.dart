import 'package:flutter/cupertino.dart';

class BuildLogoWidget extends StatelessWidget {
  const BuildLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
            child: Image.asset(
          'assets/images/logo.png',
          width: 400,
          height: 400,
        )),
      ],
    );
  }
}
