import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/presentation/common_widgets/wg_circle_image.dart';
import 'package:xplore/presentation/screen/user/bloc_follower/bloc.dart';
import 'package:xplore/utils/imager.dart';

class UserInformationWidget extends StatefulWidget {
  UserInformationWidget({Key? key, required this.user, required this.visualOnly})
      : super(key: key);
  final UserModel user;
  final bool visualOnly;
  @override
  State<UserInformationWidget> createState() => _UserInformationWidgetState();
}

class _UserInformationWidgetState extends State<UserInformationWidget> {
  late ThemeData themex = Theme.of(context);
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  _getFromGallery() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    
    // String base64Image = "";
    /*
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      base64Image = "data:image/png;base64," + base64Encode(bytes);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _userImagePreview(),
        const SizedBox(height: 20),
        _userDataPreview(),
        // const SizedBox(height: 15),
        //const MainTrophyWidget(),
        //const SizedBox(height: 15),
        //CounterFollowerAndTrips(user: user),
        const SizedBox(height: 10),
        _userBioBox(),
      ],
    );
  }

  Widget _userDataPreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [/*_userLevelIndicator(),*/ _followBuilder()],
    );
  }

  Widget _userImagePreview() {
    return Stack(
      clipBehavior: Clip.none,
      children: [_userAvatar(), _changeUserAvatar()],
    );
  }

  Widget _changeUserAvatar() {
    return !visualOnly
        ? Positioned(
            bottom: -15,
            left: 50,
            right: 0,
            child: InkWell(
              onTap: () {
                _getFromGallery();
              },
              child: CircleAvatar(
                  backgroundColor: themex.focusColor,
                  child: Icon(
                    Iconsax.picture_frame,
                    color: themex.primaryColor,
                  )),
            ))
        : const SizedBox();
  }

  Widget _userAvatar() {
    return CircleImageWidget(imageUrl: Img.getUserUrl(user));
  }

  Widget _followBuilder() {
    if (visualOnly) {
      BlocProvider.of<FollowerBloc>(context)..add(IsFollowingUser(uid: user.id ?? ''));
      return BlocBuilder<FollowerBloc, FollowerState>(
        builder: (context, state) {
          return _followButton(_isFollowing(state));
        },
      );
    }
    return const SizedBox();
  }

  Widget _followButton(bool followState) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: InkWell(
        onTap: () {
          BlocProvider.of<FollowerBloc>(context)
              .add(ToggleFollow(uid: user.id ?? '', following: followState));
        },
        child: Container(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
          decoration:
              BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
          child: Text(!followState ? "follow" : "following",
              style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: !followState ? Colors.black : Colors.green)),
        ),
      ),
    );
  }

  Widget _userBioBox() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: "bio:\n".toUpperCase() + (user.bio ?? '...'),
            style: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w300, color: themex.disabledColor),
          ),
        ]));
  }

  // Widget _userLevelIndicator() {
  //   return Text(user.username.toString());
  // }

  bool _isFollowing(FollowerState state) {
    return state.props.isNotEmpty ? state.props[0] as bool : false;
  }

  bool get visualOnly {
    return widget.visualOnly;
  }

  UserModel get user {
    return widget.user;
  }
}
