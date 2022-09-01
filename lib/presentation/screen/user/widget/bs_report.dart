import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/data/enum/report_type.dart';
import 'package:xplore/data/model/report_model.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/presentation/screen/user/bloc_report/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ReportBottomSheet extends StatefulWidget {
  const ReportBottomSheet({Key? key, required this.user}) : super(key: key);

  final UserModel user;
  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet> {
  late int _pageReportIndex = 0;
  late int _reportTypeIndex = 0;
  final List<String> _reportTypeList =
      ReportUserType.values.map((val) => val.description).toList();

  final _desc = TextEditingController();

  MediaQueryData mediaQuery = App.mediaQueryX;
  ThemeData themex = App.themex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediaQuery.size.height * 0.605,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: themex.backgroundColor,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [_pageStep()],
          ),
        ),
      ),
    );
  }

  _pageStep() {
    switch (_pageReportIndex) {
      case 0:
        return _firstStep();
      case 1:
        return _secondStep();
      case 2:
        return thirdStep();
      default:
        return Text("error");
    }
  }

  Widget _firstStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _titleReport(),
        const SizedBox(height: 20),
        _subtitle(),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.orange),
          child: Column(
            children: [
              _reportType(),
            ],
          ),
        )
      ],
    );
  }

  ListView _reportType() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => Divider(
        height: 30,
        thickness: 2,
        color: themex.scaffoldBackgroundColor,
      ),
      itemCount: _reportTypeList.length,
      itemBuilder: (BuildContext context, int index) {
        return _reportTypeButton(index);
      },
    );
  }

  InkWell _reportTypeButton(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _pageReportIndex = 1;
          _reportTypeIndex = index;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _reportTypeList[index].toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14.5, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Padding _subtitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
                "Segnala questa account allo staff di xplore, nel caso in qui questo utente non rispetta le norme della community.",
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey)),
          )
        ],
      ),
    );
  }

  Row _titleReport() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Invia segnalazione",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w600, color: themex.primaryColor),
        ),
      ],
    );
  }

  Widget thirdStep() {
    return Column(
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
                  fontSize: 16, fontWeight: FontWeight.w600, color: themex.primaryColor),
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
                    "Ti ringraziamo per aver contribuito a rendere xplore un posto migliore. :)",
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey)),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _secondStep() {
    //UserRepository _userRepository = UserRepository();
    return Column(
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
                  _reportUser();
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
                        fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey)),
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
              _reportTypeList[_reportTypeIndex].toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w600, color: themex.primaryColor),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: themex.cardColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _desc,
            maxLength: 144,
            minLines: 6,
            maxLines: 10,
            textAlign: TextAlign.start,
            style: TextStyle(color: themex.hoverColor, fontSize: 14),
            decoration: InputDecoration(
              counterStyle: TextStyle(color: themex.unselectedWidgetColor),
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Motiva la segnalazione",
              hintStyle:
                  GoogleFonts.poppins(color: themex.unselectedWidgetColor, fontSize: 14),
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
    );
  }

  _reportUser() {
    ReportModel reportData = ReportModel(
        reported: widget.user.id ?? '', causal: _reportTypeIndex, desc: _desc.toString());
    BlocProvider.of<ReportBloc>(context).add(ReportUser(reportData: reportData));
  }
}
