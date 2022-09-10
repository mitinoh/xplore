import 'package:flutter/material.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/presentation/screen/new_location/widgets/wg_base_info.dart';
import 'package:xplore/presentation/screen/new_location/widgets/wg_category.dart';
import 'package:xplore/presentation/screen/new_location/widgets/wg_create_button.dart';
import 'package:xplore/presentation/screen/new_location/widgets/wg_header.dart';
import 'package:xplore/presentation/screen/new_location/widgets/wg_image.dart';

class NewLocation extends StatefulWidget {
  const NewLocation({Key? key}) : super(key: key);
  @override
  State<NewLocation> createState() => _NewLocationState();
}

class _NewLocationState extends State<NewLocation> {

  late MediaQueryData mediaQueryX = MediaQuery.of(context);
  late ThemeData themex = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Column(
              children: [
                _headerWidget(),
                _baseInfoWidget(),
                _imageWidget(),
                _categoryWidget(),
                _createButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return HeaderWidget();
  }

  Widget _baseInfoWidget() {
    return BaseInfoWidget();
  }

  Widget _imageWidget() {
    return ImageWidget();
  }

  Widget _categoryWidget() {
    return CategoryWidget();
  }

  Widget _createButtonWidget() {
    return CreateButtonWidget();
  }
}
