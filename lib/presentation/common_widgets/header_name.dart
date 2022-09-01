import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderName extends StatelessWidget {
  HeaderName({Key? key, this.message = "", this.questionMark = false}) : super(key: key);

  String message;
  bool questionMark;

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
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
                    color: lightDark.primaryColor),
                children: <TextSpan>[
                  TextSpan(
                      text: snapshot.data,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700, color: Colors.blue)),
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
