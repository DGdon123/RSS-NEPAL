import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rss/common/utils/custom_snack_bar.dart';
import 'package:rss/data/cache/auth/auth_local_store_contract.dart';
import 'package:auth/auth.dart';
import 'package:rss/common/constants/strings.dart';
import 'package:rss/data/cache/auth/auth_local_store_impl.dart';
import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/remote_data_source/user/me_remote_data_source.dart';
import 'package:rss/data/repo/me_repo_impl.dart';
import 'package:rss/domain/usecases/user/get_me.dart';
import 'package:rss/presentation/state_management/user/me/cubit/me_cubit.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/constants/static_image_constants.dart';
import '../../../compostion_root.dart';
import '../profile/profile_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
    required this.store,
  }) : super(key: key);

  final IAuthLocalStore store;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  MeCubit? _me;
  Token? token;
  Client? c;
  ApiClient? _client;
  MeRemoteDataSourceImpl? data;
  MeRepoImpl? repo;
  IAuthLocalStore? _authLocalStore;
  GetMe? getMe;
  SharedPreferences? _sharedPrefrences;
  fetchData() async {
    _sharedPrefrences = await SharedPreferences.getInstance();
    _authLocalStore = AuthLocalStoreImpl(_sharedPrefrences);
    token = await _authLocalStore!.fetch();
  }

  @override
  void initState() {
    super.initState();
    c = Client();
    _client = ApiClient(c!);
    data = MeRemoteDataSourceImpl(_client!);
    repo = MeRepoImpl(data!);
    getMe = GetMe(repo!);
    _me = MeCubit(getMe);
    _me!.fetchMe();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: BlocProvider(
      create: (context) => _me!,
      child: BlocBuilder<MeCubit, MeState>(
        builder: (context, state) {
          if (state is MeLoading) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            maxRadius: 40,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ],
                      ),
                      baseColor: Color(0xFFEBEBF4),
                      highlightColor: Color(0xFFF4F4F4),
                    ),
                    // UserAccountsDrawerHeader(
                    //   accountName: Text(
                    //     "",
                    //     style: GoogleFonts.poppins(),
                    //   ),
                    //   accountEmail: Row(
                    //     children: [
                    //       Icon(
                    //         Icons.smartphone_outlined,
                    //         color: Colors.white,
                    //       ),
                    //       Text(
                    //         "",
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     ],
                    //   ),
                    //   currentAccountPicture: CachedNetworkImage(
                    //     imageUrl: "",
                    //     // fit: BoxFit.cover,
                    //     // width: 128,
                    //     // height: 128,
                    //     imageBuilder: (context, imageProvider) => CircleAvatar(
                    //       maxRadius: 60,
                    //       backgroundColor: Colors.white,
                    //       child: CircleAvatar(
                    //         maxRadius: 55,
                    //         backgroundImage: imageProvider,
                    //       ),
                    //     ),
                    //     placeholder: (context, url) => CircleAvatar(
                    //         backgroundImage:
                    //             AssetImage(StaticAppImage.placeHolder)),
                    //     errorWidget: (context, url, error) => CircleAvatar(
                    //         backgroundImage:
                    //             AssetImage(StaticAppImage.placeHolder)),
                    //   ),

                    //   //  GestureDetector(
                    //   //   child: CircleAvatar(
                    //   //     backgroundColor: Colors.white,
                    //   //     child: Image.asset(
                    //   //       'assets/images/logo.png',
                    //   //       height: 200.0,
                    //   //     ),
                    //   //   ),
                    //   // ),
                    //   decoration: BoxDecoration(color: primaryColor),
                    // ),

                    ListTile(
                      title: Text("Dashboard"),
                      leading: const Icon(
                        Icons.home,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                        title: Text("Profile"),
                        leading: const Icon(
                          Icons.supervised_user_circle,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        }),
                    ListTile(
                      title: Text("Logout"),
                      leading: const Icon(
                        Icons.logout_sharp,
                        color: Colors.blue,
                      ),
                      onTap: () async {
                        await widget.store.delete();
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    CompositionRoot.composeAuthUI()),
                            (route) => false);

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             CompositionRoot.composeAuthUI()));
                        customSnackBar(context, "See you next time!",
                            isError: false);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text("See you next time!"),
                        //   ),
                        // );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.47,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10, right: 20),
                      color: Colors.grey.withOpacity(0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                                height: 70.0,
                              ),
                              Text(
                                "Rastriya Samachar Samiti",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if (state is MeLoaded) {
            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    state.me.data!.customerOrgName.toString(),
                    style: GoogleFonts.poppins(),
                  ),
                  accountEmail: Row(
                    children: [
                      Icon(
                        Icons.smartphone_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        "${state.me.data!.mobileNo != null ? state.me.data!.mobileNo.toString() : ''}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  currentAccountPicture: CachedNetworkImage(
                    imageUrl: state.me.data!.oregImagePath.toString(),
                    // fit: BoxFit.cover,
                    // width: 128,
                    // height: 128,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      maxRadius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        maxRadius: 55,
                        backgroundImage: imageProvider,
                      ),
                    ),
                    placeholder: (context, url) => CircleAvatar(
                        backgroundImage:
                            AssetImage(StaticAppImage.placeHolder)),
                    errorWidget: (context, url, error) => CircleAvatar(
                        backgroundImage:
                            AssetImage(StaticAppImage.placeHolder)),
                  ),

                  //  GestureDetector(
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.white,
                  //     child: Image.asset(
                  //       'assets/images/logo.png',
                  //       height: 200.0,
                  //     ),
                  //   ),
                  // ),
                  decoration: BoxDecoration(color: primaryColor),
                ),
                ListTile(
                  title: Text("Dashboard"),
                  leading: const Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                    title: Text("Profile"),
                    leading: const Icon(
                      Icons.supervised_user_circle,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    }),
                ListTile(
                  title: Text("Logout"),
                  leading: const Icon(
                    Icons.logout_sharp,
                    color: Colors.blue,
                  ),
                  onTap: () async {
                    await widget.store.delete();
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                CompositionRoot.composeAuthUI()),
                        (route) => false);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) =>
                    //             CompositionRoot.composeAuthUI()));
                    customSnackBar(context, "See you next time!",
                        isError: false);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: Text("See you next time!"),
                    //   ),
                    // );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.47,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, right: 20),
                  color: Colors.grey.withOpacity(0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                            height: 70.0,
                          ),
                          Text(
                            "Rastriya Samachar Samiti",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          }
          if (state is MeError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Something went wrong!",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget));
                  },
                  child: Text(
                    "Refresh",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            );
          }
          return Center(child: Text("Something went wrong!!"));
        },
      ),

      // if (state is MeLoading) {
      //   return Text("data");
      // }
      // if (state is MeError) {
      //   return Text("eroo");
      // }
      // if (state is MeLoaded) {
      //   return
      // ListView(
      //     children: [
      //       UserAccountsDrawerHeader(
      //         accountName: Text(
      //           "Rastriya Samachar Samiti",
      //           style: GoogleFonts.poppins(),
      //         ),
      //         accountEmail: Text("Phone:  4262724,4262539"),
      //         currentAccountPicture: GestureDetector(
      //           child: CircleAvatar(
      //             backgroundColor: Colors.white,
      //             child: Image.asset(
      //               'assets/images/logo.png',
      //               height: 200.0,
      //             ),
      //           ),
      //         ),
      //         decoration: BoxDecoration(color: primaryColor),
      //       ),
      //       ListTile(
      //         title: Text("Dashboard"),
      //         leading: const Icon(
      //           Icons.home,
      //           color: Colors.blue,
      //         ),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //           title: Text("Profile"),
      //           leading: const Icon(
      //             Icons.supervised_user_circle,
      //             color: Colors.blue,
      //           ),
      //           onTap: () {
      //             Navigator.pop(context);
      //             Navigator.push(
      //               context,
      //               new MaterialPageRoute(
      //                 builder: (context) => ProfilePage(),
      //               ),
      //             );
      //           }),
      //       ListTile(
      //         title: Text("Logout"),
      //         leading: const Icon(
      //           Icons.logout_sharp,
      //           color: Colors.blue,
      //         ),
      //         onTap: () async {
      //           await widget.store.delete();

      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (BuildContext context) =>
      //                       CompositionRoot.composeAuthUI()));

      //           ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(
      //               content: Text("See you next time!"),
      //             ),
      //           );
      //         },
      //       ),
      //       SizedBox(
      //         height: MediaQuery.of(context).size.height * 0.47,
      //       ),
      //       Container(
      //         padding: const EdgeInsets.only(top: 10, right: 20),
      //         color: Colors.grey.withOpacity(0.1),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Row(
      //               children: [
      //                 Image.asset(
      //                   'assets/images/logo.png',
      //                   fit: BoxFit.cover,
      //                   height: 70.0,
      //                 ),
      //                 Text(
      //                   "Rastriya Samachar Samiti",
      //                   style: TextStyle(
      //                     color: primaryColor,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       )
      //     ],

      //   );

      // }
    ));
  }
}
