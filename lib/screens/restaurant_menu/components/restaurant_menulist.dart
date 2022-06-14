// import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class MenuList extends StatefulWidget {
//   const MenuList({super.key});

//   @override
//   State<MenuList> createState() => _MenuListState();
// }

// class _MenuListState extends State<MenuList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//                 itemCount: viewmodel.menuList.length,
//                 itemBuilder: (_, index) => Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                         decoration: BoxDecoration(
//                             color: kPrimaryColor,
//                             borderRadius: BorderRadius.circular(2)),
//                         height: 100,
//                         width: double.infinity,
//                         child: Text(viewmodel.menuList[index].foodName)),
//                   ),
//                 ),
//               ),
    
//   }
// }