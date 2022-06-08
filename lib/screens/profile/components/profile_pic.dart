// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodpanzu/screens/profile/profile_viewmodel.dart';
import 'package:map_mvvm/map_mvvm.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  PlatformFile? pickedFile;

  @override
  Widget build(BuildContext context) {
    return View<ProfileViewModel>(builder: (_, viewmodel) {
      return SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            if (pickedFile != null)
              ClipOval(
                child: Image.file(
                  File(viewmodel.getfilepath),
                  fit: BoxFit.cover,
                ),
              )
            else if (viewmodel.getuserpic != '')
              ClipOval(child: Image.network(viewmodel.getpic, fit: BoxFit.cover,))
            else
              ClipOval(child: Image.asset("assets/images/Profile Image.png")),
            Positioned(
              right: -16,
              bottom: 0,
              child: SizedBox(
                height: 46,
                width: 46,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.white),
                    ),
                    primary: Colors.white,
                    backgroundColor: Color(0xFFF5F6F9),
                  ),
                  onPressed: () async {
                    //use file picker to get image from devices
                    final result = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['png', 'jpg'],
                    );
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No file selected")),
                      );
                    }
                    setState(() {
                      pickedFile = result!.files.first;
                      viewmodel.filepath = pickedFile!.path!;
                      viewmodel.userPic = pickedFile!.name;
                    });
                  },
                  child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
