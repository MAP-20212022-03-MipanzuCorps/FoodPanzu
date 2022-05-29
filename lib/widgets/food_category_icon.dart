import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class FoodCategoryIcon extends StatelessWidget {
  //color will be decide based on food category
  // Color color;
  String foodCategory;
  double size;

  FoodCategoryIcon({super.key, required this.foodCategory, this.size = 30});

  @override
  Widget build(BuildContext context) {
    //if food, the icon will be orange
    if (foodCategory == "food") {
      return ClipOval(
        child: Container(
          color: Colors.orange,
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.food_bank_rounded,
              color: Colors.white, size: 20),
        ),
      );
    } else {
      //if drink, the icon will be green
      return ClipOval(
        child: Container(
          color: Colors.green,
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.local_drink_rounded,
              color: Colors.white, size: 20),
        ),
      );
    }
  }
}
