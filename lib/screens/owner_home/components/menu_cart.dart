import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/owner_home/menu_cart_viewmodel.dart';
import 'package:foodpanzu/screens/owner_home/ownerhome_viewmodel.dart';
import 'package:map_mvvm/map_mvvm.dart';
import '../../../models/menu_model.dart';
import '../../../widgets/food_category_icon.dart';

class MenuCard extends StatelessWidget {
  Menu? menu;
  Function onMenuClick;
  MenuListViewModel viewmodel;

  MenuCard(
      {super.key,
      this.menu,
      required this.onMenuClick,
      required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onMenuClick();
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 150,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                //image can be change later when firebase has been set up
                child: FutureBuilder(
                  future: viewmodel.getMenuImage(menu!.foodPicture),
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
              left: 0,
              top: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 90,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: Text(
                    "RM:${menu!.foodPrice}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFF7643),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    FoodCategoryIcon(
                      foodCategory: menu!.category,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menu!.foodName,
                          style: const TextStyle(
                            color: Color(0xFFFF7643),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Align(
                          child: Text(
                            menu!.foodDesc,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
