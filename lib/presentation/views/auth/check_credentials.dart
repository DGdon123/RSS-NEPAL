import 'dart:developer';

import 'package:auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/common/constants/strings.dart';
import 'package:rss/compostion_root.dart';
import 'package:rss/data/cache/auth/auth_local_store_contract.dart';
import 'package:rss/data/cache/auth/auth_local_store_impl.dart';
import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/remote_data_source/user/me_remote_data_source.dart';
import 'package:rss/data/repo/me_repo_impl.dart';
import 'package:rss/domain/usecases/user/get_me.dart';
import 'package:rss/presentation/state_management/user/me/cubit/me_cubit.dart';
import 'package:http/http.dart';
import 'package:rss/presentation/views/dashboard/dashboard_page.dart';
import 'package:rss/presentation/views/email_verify/email_verfy.dart';
import 'package:rss/presentation/views/subscription/subscription_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/utils/custom_snack_bar.dart';
import '../../widgets/custom_text_field.dart';
import '../sub_expired/subscription_expired_screen.dart';

// ignore: must_be_immutable
class CheckCreditalsPage extends StatefulWidget {
  // var service;

  CheckCreditalsPage({
    Key? key,
  }) : super(key: key);

  @override
  _CheckCreditalsPageState createState() => _CheckCreditalsPageState();
}

class _CheckCreditalsPageState extends State<CheckCreditalsPage> {
  MeCubit? _me;
  Token? token;
  Client? c;
  ApiClient? _client;
  MeRemoteDataSourceImpl? data;
  MeRepoImpl? repo;
  IAuthLocalStore? _authLocalStore;
  GetMe? getMe;
  SharedPreferences? _sharedPrefrences;
  checkToken() async {
    _sharedPrefrences = await SharedPreferences.getInstance();
    _authLocalStore = AuthLocalStoreImpl(_sharedPrefrences);
    token = await _authLocalStore!.fetch();
    // print(token.toString());
    // var store = getItInstance<IAuthLocalStore>();

    // token = await store.fetch();
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
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _me!,
      child: BlocBuilder<MeCubit, MeState>(
        builder: (context, state) {
          if (state is MeLoading) {
            return Scaffold(
              appBar: AppBar(),
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
            log(state.me.data!.subscription_status.toString());
            if (state.me.data!.emailVerified == "verified") {
              //
              if (state.me.data!.account_approval ==
                  'Y') if (state.me.data!.subscription_status == "active") {
                return DashBoardPage();
              } else if (state.me.data!.subscription_status == "expired") {
                return ExpiredPagePage();
              } else if (state.me.data!.subscription_status == "requested") {
                return RequestedScreenPage();
              } else if (state.me.data!.subscription_status == null) {
                //new screen
                return SubscriptionPage();
              }
              if (state.me.data!.account_approval == 'N') return StatusPage();
              //
            } else {
              return EmailVerifyPage(token: token!);
            }
          }

          if (state is MeError) {
            return CompositionRoot.composeAuthUI();
          }
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(child: Text("Something Went Wrong!"))
              ],
            ),
          );
        },
      ),
    );
  }
}

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  MeCubit? _me;
  Token? token;
  Client? c;
  ApiClient? _client;
  MeRemoteDataSourceImpl? data;
  MeRepoImpl? repo;
  IAuthLocalStore? _authLocalStore;
  GetMe? getMe;
  SharedPreferences? _sharedPrefrences;
  checkToken() async {
    _sharedPrefrences = await SharedPreferences.getInstance();
    _authLocalStore = AuthLocalStoreImpl(_sharedPrefrences);
    token = await _authLocalStore!.fetch();
    // print(token.toString());
    // var store = getItInstance<IAuthLocalStore>();

    // token = await store.fetch();
  }

  bool isLoading = false;
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
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => CompositionRoot.composeAuthUI()),
                  (route) => false);
            },
            icon: Icon(Icons.logout)),
        title: Text("Status"),
      ),
      body: BlocProvider(
        create: (context) => _me!,
        child: BlocBuilder<MeCubit, MeState>(
          builder: (context, state) {
            if (state is MeLoading) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator.adaptive()),
                // body: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Center(
                //       child: CircularProgressIndicator(),
                //     ),
                //     SizedBox(
                //       height: 20,
                //     ),
                //     Center(child: Text("Checking Your Credentials!"))
                //   ],
                // ),
              );
            }
            if (state is MeLoaded) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.21,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Your organization is under Review",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "We will let your know once the approval process is completed through your email",
                            ),
                            Text(
                              state.me.data!.email.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.94,
                                  MediaQuery.of(context).size.height * 0.054),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Color(0xff1F60BA)),
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckCreditalsPage()),
                            );
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text(
                            "Refresh",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          )),
                ],
              ));

              // if (state.me.data!.emailVerified == "verified") {
              //   if (state.me.data!.account_approval ==
              //       'N') if (state.me.data!.subscription == "active") {
              //     return DashBoardPage();
              //   } else {
              //     return SubscriptionPage();
              //   }
              //   if (state.me.data!.account_approval == 'Y') return StatusPage();
              // } else {
              //   return EmailVerifyPage(token: token!);
              // }
            }

            if (state is MeError) {
              return CompositionRoot.composeAuthUI();
            }
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(child: Text("Something Went Wrong!"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ExpiredPage extends StatefulWidget {
  const ExpiredPage({Key? key}) : super(key: key);

  @override
  State<ExpiredPage> createState() => _ExpiredPageState();
}

class _ExpiredPageState extends State<ExpiredPage> {
  MeCubit? _me;
  Token? token;
  Client? c;
  ApiClient? _client;
  MeRemoteDataSourceImpl? data;
  MeRepoImpl? repo;
  IAuthLocalStore? _authLocalStore;
  GetMe? getMe;
  SharedPreferences? _sharedPrefrences;
  checkToken() async {
    _sharedPrefrences = await SharedPreferences.getInstance();
    _authLocalStore = AuthLocalStoreImpl(_sharedPrefrences);
    token = await _authLocalStore!.fetch();
    // print(token.toString());
    // var store = getItInstance<IAuthLocalStore>();

    // token = await store.fetch();
  }

  bool isLoading = false;
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
    checkToken();
  }

  String _remarks = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => CompositionRoot.composeAuthUI()),
                  (route) => false);
            },
            icon: Icon(Icons.logout)),
        title: Text("Expired"),
      ),
      body: BlocProvider(
        create: (context) => _me!,
        child: BlocBuilder<MeCubit, MeState>(
          builder: (context, state) {
            if (state is MeLoading) {
              return Scaffold(
                appBar: AppBar(),
                // body: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Center(
                //       child: CircularProgressIndicator(),
                //     ),
                //     SizedBox(
                //       height: 20,
                //     ),
                //     Center(child: Text("Checking Your Credentials!"))
                //   ],
                // ),
              );
            }
            if (state is MeLoaded) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              Text(
                                "Your subscription  is expired.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Please request.",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            state.me.data!.email.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          width: 400,
                          child: CustomTextField(
                            keyboardType: TextInputType.text,
                            obscure: false,
                            inputAction: TextInputAction.next,
                            hint: 'Remarks',
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                            onChanged: (val) {
                              _remarks = val;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height * 0.055),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            backgroundColor: Color(0xff1F60BA),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        onPressed: () {
                          log("dsds");
                          if (_remarks.isEmpty) {
                            customSnackBar(context, "Please enter remarks");

                            return;
                          }

                          // _requestSubscriptionCubit.reqSubs(_remarks);
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => RequestedScreenPage()));
                        },
                        child: Text(
                          "Request Subscription",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        )),
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.94,
                                  MediaQuery.of(context).size.height * 0.054),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Color(0xff1F60BA)),
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckCreditalsPage()),
                            );
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text(
                            "Refresh",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          )),
                ],
              ));

              // if (state.me.data!.emailVerified == "verified") {
              //   if (state.me.data!.account_approval ==
              //       'N') if (state.me.data!.subscription == "active") {
              //     return DashBoardPage();
              //   } else {
              //     return SubscriptionPage();
              //   }
              //   if (state.me.data!.account_approval == 'Y') return StatusPage();
              // } else {
              //   return EmailVerifyPage(token: token!);
              // }
            }

            if (state is MeError) {
              return CompositionRoot.composeAuthUI();
            }
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(child: Text("Something Went Wrong!"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class RequestedScreenPage extends StatefulWidget {
  const RequestedScreenPage({Key? key}) : super(key: key);

  @override
  State<RequestedScreenPage> createState() => _RequestedScreenPageState();
}

class _RequestedScreenPageState extends State<RequestedScreenPage> {
  MeCubit? _me;
  Token? token;
  Client? c;
  ApiClient? _client;
  MeRemoteDataSourceImpl? data;
  MeRepoImpl? repo;
  IAuthLocalStore? _authLocalStore;
  GetMe? getMe;
  SharedPreferences? _sharedPrefrences;
  checkToken() async {
    _sharedPrefrences = await SharedPreferences.getInstance();
    _authLocalStore = AuthLocalStoreImpl(_sharedPrefrences);
    token = await _authLocalStore!.fetch();
    // print(token.toString());
    // var store = getItInstance<IAuthLocalStore>();

    // token = await store.fetch();
  }

  bool isLoading = false;
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
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => CompositionRoot.composeAuthUI()),
                  (route) => false);
            },
            icon: Icon(Icons.logout)),
        title: Text(""),
      ),
      body: BlocProvider(
        create: (context) => _me!,
        child: BlocBuilder<MeCubit, MeState>(
          builder: (context, state) {
            if (state is MeLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
              Scaffold(
                appBar: AppBar(),
                // body: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Center(
                //       child: CircularProgressIndicator(),
                //     ),
                //     SizedBox(
                //       height: 20,
                //     ),
                //     Center(child: Text("Checking Your Credentials!"))
                //   ],
                // ),
              );
            }
            if (state is MeLoaded) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              Text(
                                "Your subscription has been requested successfully",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Please wait.",
                            style: TextStyle(fontSize: 14),
                          ),
                          // Text(
                          //   state.me.data!.email.toString(),
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold, fontSize: 15),
                          // ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.94,
                                  MediaQuery.of(context).size.height * 0.054),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Color(0xff1F60BA)),
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckCreditalsPage()),
                            );
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text(
                            "Refresh",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          )),
                ],
              ));

              // if (state.me.data!.emailVerified == "verified") {
              //   if (state.me.data!.account_approval ==
              //       'N') if (state.me.data!.subscription == "active") {
              //     return DashBoardPage();
              //   } else {
              //     return SubscriptionPage();
              //   }
              //   if (state.me.data!.account_approval == 'Y') return StatusPage();
              // } else {
              //   return EmailVerifyPage(token: token!);
              // }
            }

            if (state is MeError) {
              return CompositionRoot.composeAuthUI();
            }
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(child: Text("Something Went Wrong!"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
