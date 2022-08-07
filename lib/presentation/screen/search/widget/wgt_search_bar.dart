import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/presentation/screen/search/bloc/bloc.dart';
import 'package:xplore/utils/class/debouncer.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({Key? key}) : super(key: key);
  late ThemeData _lightDark;
  late BuildContext _blocContext;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    _blocContext = context;
    _lightDark = Theme.of(context);

    return Row(
      children: [
        Expanded(
            child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: _lightDark.cardColor,
              borderRadius: BorderRadius.circular(20)),
          child: Focus(
            /*onFocusChange: (hasFocus) {
              setState(() {
                _ptGridVisible = hasFocus;
              });
            },*/
            child: TextField(
              onChanged: (String value) {
                _debouncer.run(() => _filterLocation(value));
              },
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                  color: _lightDark.hoverColor, fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "cerca un posto o un @utente",
                hintStyle: GoogleFonts.poppins(
                    color: _lightDark.unselectedWidgetColor, fontSize: 14),
                border: const OutlineInputBorder(),
                suffixIconColor: Colors.blue,
                prefixIcon: IconButton(
                  icon: Icon(
                    Iconsax.search_normal,
                    color: Colors.blue,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    //  applyFilterName();
                  },
                ),
              ),
              autofocus: true,
            ),
          ),
        ))
      ],
    );
  }

  _filterLocation(String filter) {
    if (filter.startsWith("@")) {
      BlocProvider.of<SearchLocationBloc>(_blocContext)
          .add(GetSearchUsersList(searchName: filter));
    } else {
      BlocProvider.of<SearchLocationBloc>(_blocContext)
          .add(GetSearchLocationList(searchName: filter));
    }
  }
}
