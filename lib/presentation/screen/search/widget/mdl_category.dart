import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoryModal extends StatelessWidget {
  const CategoryModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("category modal");
    /*
    
    return showModalBottomSheet<void>(
        //useRootNavigator: true,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: _lightDark.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return BlocProvider(
            create: (_) => _locCatBloc,
            child: BlocListener<LocationCategoryBloc, LocationcategoryState>(
              listener: (context, state) {
                if (state is LocationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("error"),
                    ),
                  );
                }
              },
              child: BlocBuilder<LocationCategoryBloc, LocationcategoryState>(
                builder: (context, state) {
                  if (state is LocationcategoryInitial ||
                      state is LocationCategoryLoading) {
                    return const LoadingIndicator();
                  } else if (state is LocationcategoryLoaded) {
                    return BuildListCardCategory(
                      context: context,
                      model: state.locationCategoryModel,
                      homeBloc: _searchHomeBloc,
                    );
                  } else if (state is LocationcategoryError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          );
        });
     */
  }
}
