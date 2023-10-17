import 'dart:developer';

import 'package:auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/compostion_root.dart';
import 'package:rss/data/cache/auth/auth_local_store_contract.dart';
import 'package:rss/di/get_it.dart';
import 'package:rss/presentation/state_management/subscription/cubit/request_subscription_cubit.dart';
import 'package:rss/presentation/views/profile/profile_page.dart';
import 'package:rss/presentation/widgets/custom_text_field.dart';

import '../../../common/utils/custom_snack_bar.dart';
import '../auth/check_credentials.dart';

class ExpiredPagePage extends StatefulWidget {
  const ExpiredPagePage({Key? key}) : super(key: key);

  @override
  _ExpiredPagePageState createState() => _ExpiredPagePageState();
}

class _ExpiredPagePageState extends State<ExpiredPagePage> {
  late IAuthService service;
  late IAuthLocalStore store;
  late RequestSubscriptionCubit _requestSubscriptionCubit;

  String _remarks = '';
  @override
  void initState() {
    super.initState();
    store = getItInstance<IAuthLocalStore>();
    _requestSubscriptionCubit = getItInstance<RequestSubscriptionCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    _requestSubscriptionCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.person_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                await store.delete();
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (BuildContext context) =>
                            CompositionRoot.composeAuthUI()),
                    (route) => false);
                // Navigator.push(
                //     context,
                //    );
                customSnackBar(context, "See you next time!");
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text("See you next time!"),
                //   ),
                // );
              },
            ),
            Divider()
          ],
          title: Text(
            'Subscription ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocProvider(
            create: (context) => _requestSubscriptionCubit,
            child: BlocConsumer<RequestSubscriptionCubit,
                RequestSubscriptionState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.11,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: Color(0xff7C0000).withOpacity(0.8),
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
                            // Text(
                            //   "Please request.",
                            //   style: TextStyle(fontSize: 14),
                            // ),
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
                    SizedBox(
                      height: 20,
                    ),
                    // Center(
                    //   child: MaterialButton(
                    //     color: Colors.blueGrey,
                    //     child: Text("Request Subscription",
                    //         style:
                    //             TextStyle(fontSize: 20, color: Colors.white)),
                    //     onPressed: () {
                    //       _requestSubscriptionCubit.reqSubs(_remarks!);
                    //     },
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height * 0.054),
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

                            _requestSubscriptionCubit.reqSubs(_remarks);
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        RequestedScreenPage()));
                          },
                          child: Text(
                            "Request Subscription",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckCreditalsPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height * 0.054),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Color(0xff1F60BA)),
                                  borderRadius: BorderRadius.circular(4))),
                          child: Text(
                            "Refresh if Subscribed",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          )),
                    ),
                    // Center(
                    //   child: MaterialButton(
                    //     color: Colors.blueGrey,
                    //     child: Text(
                    //       "Refresh if Subscribed",
                    //       style: TextStyle(fontSize: 20, color: Colors.white),
                    //     ),
                    //     onPressed: () {
                    //       Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => CheckCreditalsPage()),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                );
              },
              listener: (context, state) {
                if (state is LoadingState) {
                  _showLoader();
                }
                if (state is RequestSubscriptionSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.message,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  );
                  _hideLoader();
                }
                if (state is ErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.message.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  );
                  _hideLoader();
                }
              },
            )),
      ),
    );
  }

  _showLoader() {
    var alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
        ),
      ),
    );
    showDialog(
        context: context, barrierDismissible: true, builder: (_) => alert);
  }

  _hideLoader() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
