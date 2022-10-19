import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/presentation/screen/new_location/bloc/new_location_bloc.dart';
import 'package:xplore/utils/class/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseInfoWidget extends StatelessWidget {
  BaseInfoWidget({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _indicationController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);
  late ThemeData themex;
  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    themex = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 5),
        _locationName(),
        const SizedBox(height: 5),
        _adressName(),
        const SizedBox(height: 5),
        _locationDesc(),
        const SizedBox(height: 5),
        _locationTips(),
        const SizedBox(height: 5),
      ],
    );
  }

  Row _locationName() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: themex.cardColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _nameController,
            maxLength: 90,
            textAlign: TextAlign.start,
            style: TextStyle(color: themex.indicatorColor, fontSize: 14),
            onChanged: (String value) {
              _debouncer.run(() => BlocProvider.of<NewLocationBloc>(_buildContext)
                  .newLocation
                  .name = value);
            },
            decoration: InputDecoration(
              counterStyle: TextStyle(color: themex.disabledColor),
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Location/Experience name",
              hintStyle: GoogleFonts.poppins(color: themex.disabledColor, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.flag,
                color: themex.indicatorColor,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  Row _adressName() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: themex.cardColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _addressController,
            textAlign: TextAlign.start,
            style: TextStyle(color: themex.indicatorColor, fontSize: 14),
            onChanged: (String value) {
              _debouncer.run(() => BlocProvider.of<NewLocationBloc>(_buildContext)
                  .newLocation
                  .address = value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Place address",
              hintStyle: GoogleFonts.poppins(color: themex.disabledColor, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.location,
                color: themex.indicatorColor,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  Row _locationDesc() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: themex.cardColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _descController,
            textAlign: TextAlign.start,
            minLines: 6,
            maxLines: 10,
            maxLength: 288,
            style: TextStyle(color: themex.indicatorColor, fontSize: 14),
            onChanged: (String value) {
              _debouncer.run(() => BlocProvider.of<NewLocationBloc>(_buildContext)
                  .newLocation
                  .desc = value);
            },
            decoration: InputDecoration(
              counterStyle: TextStyle(color: themex.disabledColor),
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Short description of the place or experience you want to enter...",
              hintStyle: GoogleFonts.poppins(color: themex.disabledColor, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.note,
                color: themex.indicatorColor,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  Row _locationTips() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: themex.cardColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _indicationController,
            textAlign: TextAlign.start,
            minLines: 6,
            maxLines: 10,
            maxLength: 144,
            style: TextStyle(color: themex.indicatorColor, fontSize: 14),
            onChanged: (String value) {
              _debouncer.run(() => BlocProvider.of<NewLocationBloc>(_buildContext)
                  .newLocation
                  .indication = value);
            },
            decoration: InputDecoration(
              counterStyle: TextStyle(color: themex.disabledColor),
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText:
                  "A few tricks other users should know, such as which season is best to venture here...",
              hintStyle: GoogleFonts.poppins(color: themex.disabledColor, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.lamp_on,
                color: themex.indicatorColor,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }
}
// BlocProvider.of<NewLocationBloc>(context).newLocation
