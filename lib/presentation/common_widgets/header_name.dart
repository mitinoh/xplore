import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderName extends StatelessWidget {
  HeaderName(
      {Key? key, this.message = "", this.questionMark = false, this.username = false})
      : super(key: key);

  String message;
  bool questionMark;
  bool username;

  @override
  Widget build(BuildContext context) {
    ThemeData themex = Theme.of(context);
    return FutureBuilder<String>(
        future: getUserName,
        builder: (context, snapshot) {
          return Expanded(
            child: RichText(
              text: TextSpan(
                text: message,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: themex.indicatorColor),
                children: <TextSpan>[
                  TextSpan(
                      text: username ? snapshot.data : '',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: themex.primaryColor)),
                  TextSpan(text: questionMark ? '?' : ''),
                ],
              ),
            ),
          );
        });
  }

  Future<String> get getUserName {
    return Future.value("nome da sistemare");
  }
}
