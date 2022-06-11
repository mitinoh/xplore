import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/app/user/repository/user_repository.dart';
import 'package:xplore/core/UIColors.dart';

class HeaderName extends StatelessWidget {
  HeaderName({Key? key, required this.message, required this.questionMark}) : super(key: key);
  String message = "";
  bool questionMark = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: UserRepository.getUserName(),
        builder: (context, snapshot) {
          return Expanded(
            child: RichText(
              text: TextSpan(
                text: message,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: snapshot.data,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: UIColors.blue)),
                    TextSpan(text: questionMark ? '?' : '') ,
                ],
              ),
            ),
          );
        });
  }
}
