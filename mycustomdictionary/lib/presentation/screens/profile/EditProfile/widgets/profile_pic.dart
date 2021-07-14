import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  final String picPath;
  const ProfilePic({
    Key? key,
    required this.picPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(picPath),
          ),
          Positioned(
            bottom: 0,
            right: -12,
            child: SizedBox(
              height: 46,
              width: 46,
              child: ElevatedButton(
                onPressed: () {
                  // get picture from user and set it profile photo
                },
                child: SvgPicture.asset("assets/icons/CameraIcon.svg"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    primary: Color(0xFFF5F6F9),
                    padding: EdgeInsets.zero,
                    side: BorderSide(color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
