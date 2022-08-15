import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:xplore/model/repository/follower_repository.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/user/bloc_follower/bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_user/bloc.dart';
import 'package:xplore/utils/pref.dart';

class UserInformationWidget extends StatefulWidget {
  UserInformationWidget(
      {Key? key, required this.user, required this.visualOnly})
      : super(key: key);
  final UserModel user;
  final bool visualOnly;
  @override
  State<UserInformationWidget> createState() => _UserInformationWidgetState();
}

class _UserInformationWidgetState extends State<UserInformationWidget> {
  //FollowerRepository _followerRepository = FollowerRepository();

  // bool followState = false;

  isFollwing() async {
    /*
    bool following =
        await _followerRepository.isFollowing(widget.user.id ?? '');
    setState(() {
      followState = following;
    });
    */
  }

  @override
  void initState() {
    if (widget.user != null) {
      //_userBio = Future.value(widget.user?.bio ?? "");
      //_userName = Future.value(widget.user?.name ?? "");
      isFollwing();
    }
    super.initState();
  }

  //XFile? image;
  //final ImagePicker _picker = ImagePicker();

  _getFromGallery() async {
    // _picker.pickImage(source: ImageSource.gallery);
    // image = await _picker.pickImage(source: ImageSource.gallery);
    /*
    String base64Image = "";
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      base64Image = "data:image/png;base64," + base64Encode(bytes);
    }*/
  }
  late ThemeData _lightDark;
  @override
  Widget build(BuildContext ctx) {
    _lightDark = Theme.of(context);
    return Column(
      children: [
        _userImagePreview(),
        const SizedBox(height: 20),
        _userDataPreview(),
        // const SizedBox(height: 15),
        //const MainTrophyWidget(),
        //const SizedBox(height: 15),
        //CounterFollowerAndTrips(user: widget.user),
        const SizedBox(height: 10),
        _userBioBox(),
      ],
    );
  }

  Widget _userDataPreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_userLevelIndicator(), _followBuilder()],
    );
  }

  Widget _userImagePreview() {
    return Stack(
      clipBehavior: Clip.none,
      children: [_userAvatar(), _changeUserAvatar()],
    );
  }

  Widget _changeUserAvatar() {
    return !widget.visualOnly
        ? Positioned(
            //!questo tasto sarà visibile solo quando si visuelezzarà il profilo di un altro utente
            bottom: -15,
            left: 50,
            right: 0,
            child: InkWell(
              onTap: () {
                _getFromGallery();
                //qui si scatena l'evento del caricamento
              },
              child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Icon(
                    Iconsax.picture_frame,
                    color: Colors.blue,
                  )),
            ))
        : const SizedBox();
  }

  Widget _userAvatar() {
    return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.blueAccent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            imageUrl:
                "https://107.174.186.223.nip.io/img/user/62f4ba41bb478cf097896970.jpg",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => const LoadingIndicator(),
            errorWidget: (context, url, error) => Center(
              child: Icon(Iconsax.user, size: 30, color: Colors.lightBlue),
            ),
          ),
        ));
  }

  Widget _followBuilder() {
    return (widget.visualOnly)
        ? BlocProvider(
            create: (context) => BlocProvider.of<FollowerBloc>(context)
              ..add(IsFollowingUser(
                  uid: widget.user.id ??
                      '')), //UserBloc(userRepository: RepositoryProvider.of<UserRepository>(context)),
            child: BlocBuilder<FollowerBloc, FollowerState>(
              builder: (context, state) {
                return _followButton(
                    state.props.isNotEmpty ? state.props[0] as bool : false);
              },
            ),
          )
        : const SizedBox();
  }
  /*
  
  


  
  
   */

  Widget _followButton(bool followState) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: InkWell(
        onTap: () {
          BlocProvider.of<FollowerBloc>(context).add(
              ToggleFollow(uid: widget.user.id ?? '', following: followState));
        },
        child: Container(
          padding:
              const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(20)),
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
            text: "La tua biografia:\n".toUpperCase() +
                widget.user.bio.toString(),
            style: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
          ),
        ]));
  }

  Widget _userLevelIndicator() {
    return Text(widget.user.username.toString());
  }
}
