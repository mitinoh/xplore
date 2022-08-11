import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/user/bloc_user/bloc.dart';

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

  bool followState = false;

  isFollwing() async {
    bool following = true;
    // await _followerRepository.isFollowing(widget.user?.sId ?? '');
    setState(() {
      followState = following;
    });
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
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UpdatedUserInfo) {
          // _userBio = UserRepository.getUserBio();
          // _userName = UserRepository.getUserName();
        }
      },
      child: Column(
        children: [
          _userImagePreview(),
          const SizedBox(height: 20),
          _userDataPreview(),
          const SizedBox(height: 15),
          //const MainTrophyWidget(),
          const SizedBox(height: 15),
          //CounterFollowerAndTrips(user: widget.user),
          const SizedBox(height: 10),
          _userBioBox(),
        ],
      ),
    );
  }

  Widget _userDataPreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_userLevelIndicator(), _followButton()],
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

  Widget _followButton() {
    return (widget.visualOnly)
        ? Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: () {
                /*
                      if (followState) {
                        FollowerBloc().add(FollowerUnfollowUserEvent(
                            uid: widget.user?.sId ?? ''));
                      } else {
                        FollowerBloc().add(FollowerFollowUserEvent(
                            uid: widget.user?.sId ?? ''));
                      }
                      setState(() {
                        // TODO : fare questo con un event handler in base a cosa ritorna backend
                        followState = !followState;
                      });*/
              },
              child: Container(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(!followState ? "follow" : "following",
                    style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: !followState ? Colors.black : Colors.green)),
              ),
            ),
          )
        : const SizedBox();
  }

  Widget _userBioBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: "La tuo biografia:\n".toUpperCase() +
                    widget.user.bio.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey),
              ),
            ]),
          ))
        ],
      ),
    );
  }

  Widget _userLevelIndicator() {
    return RichText(
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.end,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: widget.user.username,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _lightDark.primaryColor)),
          /*TextSpan(
              text: ' LV. 1',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff3498db)))*/
        ],
      ),
    );
  }
}
