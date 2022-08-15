import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/model/model/user_model.dart';

// ignore: must_be_immutable
class ReportBottomSheet extends StatefulWidget {
  const ReportBottomSheet({Key? key, required this.user}) : super(key: key);

  final UserModel user;
  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet> {
  late int _pageReportIndex = 0;
  late int _reportTypeIndex = 0;
  final List<String> _reportType = [
    "Spam",
    "Nudo o atti sessuali",
    "Truffa o frode",
    "Discorsi o simboli che incitano all'odio",
    "Bullismo o intimidazioni",
    "Altro"
  ];
  final _desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);
    return Container(
      height: mediaQuery.size.height * 0.605,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: lightDark.backgroundColor,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              firstStep(lightDark),
              secondStep(lightDark),
              thirdStep(lightDark),
            ],
          ),
        ),
      ),
    );
  }

  Visibility firstStep(ThemeData lightDark) {
    return Visibility(
      visible: _pageReportIndex == 0 ? true : false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Invia segnalazione",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: lightDark.primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                      "Segnala questa account allo staff di XPLORE, nel caso in qui questo utente non rispetta le norme della community.",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey)),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orange),
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => Divider(
                    height: 30,
                    thickness: 2,
                    color: lightDark.scaffoldBackgroundColor,
                  ),
                  itemCount: _reportType.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          print(index);
                          _pageReportIndex = 1;
                          _reportTypeIndex = index;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _reportType[index].toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Visibility thirdStep(ThemeData lightDark) {
    return Visibility(
        visible: _pageReportIndex == 2 ? true : false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("chiudi",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.lightBlue)),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Segnalazione effettuata",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: lightDark.primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                        "Ti ringraziamo per aver contribuito a rendere XPLORE un posto migliore. :)",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey)),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Visibility secondStep(ThemeData lightDark) {
    //UserRepository _userRepository = UserRepository();
    return Visibility(
        visible: _pageReportIndex == 1 ? true : false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        _pageReportIndex = 0;
                      });
                    },
                    child: const Icon(Iconsax.arrow_left)),
                InkWell(
                  onTap: () {
                    setState(() {
                      /*
                      _userRepository.reportUser(map: {
                        "reported": widget.user.id,
                        "causal": _reportTypeIndex,
                        "desc": _desc.toString(),
                      });*/
                      _pageReportIndex = 2;
                    });
                  },
                  child: Text("invia",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.lightBlue)),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                        "Secondo passo. Stai segnalato questo utente per la seguente voce:",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey)),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _reportType[_reportTypeIndex].toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: lightDark.primaryColor),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
              decoration: BoxDecoration(
                  color: lightDark.cardColor,
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: _desc,
                maxLength: 144,
                minLines: 6,
                maxLines: 10,
                textAlign: TextAlign.start,
                style: TextStyle(color: lightDark.hoverColor, fontSize: 14),
                decoration: InputDecoration(
                  counterStyle:
                      TextStyle(color: lightDark.unselectedWidgetColor),
                  contentPadding: const EdgeInsets.all(15.0),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Motiva la segnalazione",
                  hintStyle: GoogleFonts.poppins(
                      color: lightDark.unselectedWidgetColor, fontSize: 14),
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(
                    Iconsax.flag,
                    color: Colors.blue,
                  ),
                ),
                autofocus: false,
              ),
            )
          ],
        ));
  }
}
