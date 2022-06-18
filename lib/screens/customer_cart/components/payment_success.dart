import 'package:flutter/material.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/utils/size_config.dart';

class PaymentSucess extends StatelessWidget {
  const PaymentSucess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Image.asset(
            "assets/images/success.png",
            height: SizeConfig.screenHeight * 0.4, //40%
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Text(
            "Payment Success",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.6,
            child: DefaultButton(
              text: "Back to Cart",
              press: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
