import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/common/utils/custom_snack_bar.dart';
import 'package:rss/compostion_root.dart';
import 'package:rss/data/cache/auth/auth_local_store_contract.dart';
import 'package:rss/di/get_it.dart';
import 'package:rss/presentation/state_management/auth/resent_verification_email/cubit/resent_email_verification_cubit.dart';
import 'package:rss/presentation/views/auth/check_credentials.dart';
import 'package:rss/presentation/views/profile/profile_page.dart';

class EmailVerifyPage extends StatefulWidget {
  final Token token;
  EmailVerifyPage({Key? key, required this.token}) : super(key: key);

  @override
  _EmailVerifyPageState createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  late ResentEmailVerificationCubit _resentEmailVerificationCubit;
  late IAuthService service;
  late IAuthLocalStore store;

  @override
  void initState() {
    super.initState();
    store = getItInstance<IAuthLocalStore>();
    _resentEmailVerificationCubit =
        getItInstance<ResentEmailVerificationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
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

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CompositionRoot.composeAuthUI()));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("See you next time!"),
                  ),
                );
              },
            ),
            Divider()
          ],
          title: Text(
            'Email Verification ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocProvider(
          create: (context) => _resentEmailVerificationCubit,
          child: BlocConsumer<ResentEmailVerificationCubit,
              ResentEmailVerificationState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "You have not verified your email!",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                          BlocProvider.of<ResentEmailVerificationCubit>(context)
                              .resentVerficationMail();
                        },
                        child: Text(
                          "Resend Email Verification",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        )),
                  ),
                  // Center(
                  //   child: MaterialButton(
                  //     color: Colors.blueGrey,
                  //     child: Text(
                  //       "Resend Email Verification",
                  //       style: TextStyle(fontSize: 20, color: Colors.white),
                  //     ),
                  //     onPressed: () {
                  //       BlocProvider.of<ResentEmailVerificationCubit>(context)
                  //           .resentVerficationMail();
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                          "Refresh if Verified",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        )),
                  ),
                ],
              );
            },
            listener: (context, state) {
              if (state is LoadingState) {
                _showLoader();
              }
              if (state is EmailResentSuccessState) {
                customSnackBar(context, state.message, isError: false);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text(
                //       state.message,
                //       style: Theme.of(context)
                //           .textTheme
                //           .caption!
                //           .copyWith(color: Colors.white, fontSize: 16.0),
                //     ),
                //   ),
                // );

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
          ),
        ),
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
