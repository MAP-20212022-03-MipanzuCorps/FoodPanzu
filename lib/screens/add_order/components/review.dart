import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 18,
        ),
        SizedBox(width: 4),
        Text(
          "4.5",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 4),
        Text(
          "(30+)",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 183, 181, 181),
          ),
        ),
        SizedBox(width: 10),
        Text(
          "See Review",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFF7643),
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
