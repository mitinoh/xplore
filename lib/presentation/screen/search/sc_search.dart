import 'package:flutter/material.dart';
import 'package:xplore/presentation/screen/search/widget/wgt_grid_header.dart';
import 'package:xplore/presentation/screen/search/widget/wgt_grid.dart';
import 'package:xplore/presentation/screen/search/widget/wgt_search_bar.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Scaffold(
            body: SafeArea(
                child: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 0),
                _searchBar(),
                const SizedBox(
                  height: 15,
                ),
                //suggestedLocation(),
                _gridHeader(),
                _grid()
              ],
            ),
          ),
        ],
      ),
    ))));
  }

  Widget _gridHeader() {
    return GridHeaderWidget();
  }

  Widget _searchBar() {
    return SearchBarWidget();
  }

  Widget _grid() {
    return GridWidget();
  }
}
