import 'package:flutter/material.dart';

import '../../../utils/app_style.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function method;
  final Color? color;
  const CalculatorButton({
    Key? key,
    required this.text,
    required this.method,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => method(),
        child: SizedBox(
          height: mediaQueryData.size.width * 0.15,
          width: mediaQueryData.size.width * 0.15,
          child: Center(
            child: Text(
              text,
              style: AppStyle.instance.textStyle(
                fontSize: 20,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
