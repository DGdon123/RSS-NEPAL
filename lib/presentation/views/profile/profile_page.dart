import 'dart:developer';

import 'package:auth/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/common/constants/strings.dart';
import 'package:rss/data/cache/auth/auth_local_store_contract.dart';
import 'package:rss/data/cache/auth/auth_local_store_impl.dart';
import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/model/users/me_model.dart';
import 'package:rss/data/remote_data_source/user/me_remote_data_source.dart';
import 'package:rss/data/repo/me_repo_impl.dart';
import 'package:rss/domain/usecases/user/get_me.dart';
import 'package:rss/presentation/state_management/user/me/cubit/me_cubit.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/static_image_constants.dart';
import '../../widgets/address_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocProvider(
        create: (context) => _me!,
        child: BlocBuilder<MeCubit, MeState>(
          builder: (context, state) {
            if (state is MeLoading) {
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(child: Text("Checking Your Credentials!"))
                  ],
                ),
              );
            }
            if (state is MeLoaded) {
              log(state.me.data!.oregImagePath.toString());
              var status = state.me.data!.subscription == 'active'
                  ? "Active"
                  : "Not active";
              return Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Text(""),
                              Positioned(
                                top: -50,
                                child: CachedNetworkImage(
                                    imageUrl:
                                        state.me.data!.oregImagePath.toString(),
                                    // fit: BoxFit.cover,
                                    // width: 128,
                                    // height: 128,
                                    imageBuilder: (context, imageProvider) =>
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0),
                                          child: CircleAvatar(
                                            maxRadius: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              maxRadius: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.06,
                                              backgroundImage: imageProvider,
                                            ),
                                          ),
                                        ),
                                    placeholder: (context, url) => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0),
                                          child: CircleAvatar(
                                            maxRadius: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              maxRadius: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.06,
                                              backgroundImage: AssetImage(
                                                  StaticAppImage.placeHolder),
                                            ),
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 40),
                                          child: CircleAvatar(
                                            maxRadius: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              maxRadius: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.06,
                                              backgroundImage: AssetImage(
                                                  StaticAppImage.placeHolder),
                                            ),
                                          ),
                                        )),
                              ),
                              Positioned(
                                top: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.business_outlined,
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  state.me.data!.customerOrgName
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.email_outlined,
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  state.me.data!.email
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // SizedBox(
                                        //   width:
                                        //       MediaQuery.of(context).size.width *
                                        //           0.15,
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 34, vertical: 0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Subscription Status: ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color: primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                state.me.data!
                                                    .subscription_status
                                                    .toString()
                                                    .toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color:
                                                            status == "Active"
                                                                ? Colors.green
                                                                : Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 40,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 30),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(4, 4),
                                            blurRadius: 1,
                                            color: Colors.blueAccent
                                                .withOpacity(0.1),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Subscription date : ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color: primaryColor),
                                              ),
                                              Text(
                                                state.me.data!
                                                    .subscription_start_date
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11,
                                                      color: status == "Active"
                                                          ? Colors.green
                                                          : Colors.red,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Expiry date : ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color: primaryColor),
                                              ),
                                              Text(
                                                state.me.data!
                                                    .subscription_end_date
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11,
                                                      color: status == "Active"
                                                          ? Colors.green
                                                          : Colors.red,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: AddressWidget(
                                        province:
                                            state.me.data!.province != null
                                                ? state.me.data!.province!
                                                    .pradeshName
                                                    .toString()
                                                : "",
                                        muni: state.me.data!.muni != null
                                            ? state.me.data!.muni!.muniName
                                                .toString()
                                            : "",
                                        district:
                                            state.me.data!.district != null
                                                ? state.me.data!.district!
                                                    .englishName
                                                    .toString()
                                                : "",
                                      ),
                                    ),
                                    buildAbout(state.me),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
      ),
    );
  }

  Widget buildName(String user, String email, String status) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.business_outlined,
                  size: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  user,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.email,
                  size: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  email,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Text(
            //       "Subscription Status: ",
            //       style: Theme.of(context)
            //           .textTheme
            //           .headline3!
            //           .copyWith(color: primaryColor),
            //     ),
            //     Text(
            //       "$status",
            //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //             fontWeight: FontWeight.bold,
            //             color: status == "Active" ? Colors.green : Colors.red,
            //           ),
            //     ),
            //   ],
            // ),
          ],
        ),
      );

  Widget buildAbout(MeModel user) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 6,
                    color: Colors.blueAccent.withOpacity(0.1),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    "Ward no : ${user.data!.wardNo != null ? user.data!.wardNo.toString() : ''}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black

                        // TextStyle(fontSize: 16, height: 1.4),
                        ),
                  ),
                  Text(
                    "Tole : ${user.data!.tole != null ? user.data!.tole.toString() : ''}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black

                        // TextStyle(fontSize: 16, height: 1.4),
                        ),
                  ),
                  Text(
                    "House no. : ${user.data!.houseNo != null ? user.data!.houseNo.toString() : ''}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black

                        // TextStyle(fontSize: 16, height: 1.4),
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 6,
                    color: Colors.blueAccent.withOpacity(0.1),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Details:',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Mobile no. : ${user.data!.mobileNo != null ? user.data!.mobileNo.toString() : ''}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black

                        // TextStyle(fontSize: 16, height: 1.4),
                        ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Landline no. : ${user.data!.landline != null ? user.data!.landline.toString() : ''}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black

                        // TextStyle(fontSize: 16, height: 1.4),
                        ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Contact person phone. : ${user.data!.contactPersonMobileNo != null ? user.data!.contactPersonMobileNo.toString() : ''}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black

                        // TextStyle(fontSize: 16, height: 1.4),
                        ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Landline no. : ${user.data!.landline != null ? user.data!.landline.toString() : ''}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black

                        // TextStyle(fontSize: 16, height: 1.4),
                        ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Contact person email. : ${user.data!.contactPersonEmail != null ? user.data!.contactPersonEmail.toString() : ''}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black

                        // TextStyle(fontSize: 16, height: 1.4),
                        ),
                  ),
                ],
              ),
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Contact Details',
            //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //           fontWeight: FontWeight.bold, color: Colors.black),
            //     ),
            //     Text(
            //         "Mobile no. : ${user.data!.mobileNo != null ? user.data!.mobileNo.toString() : ''}",
            //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 12,
            //             color: Colors.black

            //             // TextStyle(fontSize: 16, height: 1.4),
            //             )),
            //     Text(
            //         "Landline no. : ${user.data!.landline != null ? user.data!.landline.toString() : ''}",
            //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 12,
            //             color: Colors.black

            //             // TextStyle(fontSize: 16, height: 1.4),
            //             )),
            //     Text(
            //         "Contact person phone. : ${user.data!.contactPersonMobileNo != null ? user.data!.contactPersonMobileNo.toString() : ''}",
            //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 12,
            //             color: Colors.black

            //             // TextStyle(fontSize: 16, height: 1.4),
            //             )),
            //     Text(
            //         "Contact person telephone. : ${user.data!.contactPersonTelephone != null ? user.data!.contactPersonTelephone.toString() : ''}",
            //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 12,
            //             color: Colors.black

            //             // TextStyle(fontSize: 16, height: 1.4),
            //             )),
            //     Text(
            //         "Contact person email. : ${user.data!.contactPersonEmail != null ? user.data!.contactPersonEmail.toString() : ''}",
            //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 12,
            //             color: Colors.black

            //             // TextStyle(fontSize: 16, height: 1.4),
            //             )),
            //   ],
            // ),
          ],
        ),
      );
}
