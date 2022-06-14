import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/screens/add_order/add_order_viewmodel.dart';
import 'package:map_mvvm/map_mvvm.dart';

class MenuImage extends StatelessWidget {
  Future<String>? pictureUrl;
  MenuImage({super.key, required this.pictureUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              //image can be change later when firebase has been set up
              child: FutureBuilder(
                future: pictureUrl,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    return Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    );
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: Color(0xFFFF7643),
                ),
                child: const Center(
                    child: Icon(
                  Icons.favorite_outlined,
                  size: 15,
                  color: Colors.white,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
