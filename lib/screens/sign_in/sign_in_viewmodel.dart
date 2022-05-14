// void signInWithEmailAndPassword() async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       Get.offAll(HomeView());
//     } catch (e) {
//       print(e.message);
//       Get.snackbar(
//         'Error login account',
//         e.message,
//         colorText: Colors.black,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }