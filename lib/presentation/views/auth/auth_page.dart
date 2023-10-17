import 'dart:developer';

import 'package:auth/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rss/common/constants/static_image_constants.dart';
import 'package:rss/data/model/regisrtaion/org_type_model.dart';
import 'package:rss/di/get_it.dart';
import 'package:rss/presentation/state_management/auth/auth_cubit.dart';
import 'package:rss/presentation/state_management/auth/auth_state.dart';
import 'package:rss/presentation/state_management/auth/org_type/org_type_cubit.dart';
import 'package:rss/presentation/views/auth/auth_page_adapter.dart';
import 'package:rss/presentation/widgets/custom_text_field.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import '../../../common/constants/strings.dart';
import '../../../common/utils/custom_snack_bar.dart';

class AuthPage extends StatefulWidget {
  AuthPage(this._manager, this._adapter);

  final AuthManager _manager;
  final IAuthPageAdapter _adapter;

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool obscurepasswordValue = true;
  bool obscureConfirmpasswordValue = true;
  PageController _controller = PageController();
  late OrgTypeCubit orgTypeCubit;
  String _email = '';
  String _password = '';
  // ignore: non_constant_identifier_names
  String _customer_org_name = '';
  // ignore: non_constant_identifier_names
  String _password_confirmation = '';
  int? _orgType;
  int index = 0;

  bool remember = false;
  late IAuthService service;
  @override
  void initState() {
    super.initState();
    orgTypeCubit = getItInstance<OrgTypeCubit>();
    orgTypeCubit.fetchOrgTypes();
  }

  @override
  void dispose() {
    super.dispose();
    orgTypeCubit.close();
  }

  togglepasswordObscure() {
    setState(() {
      obscurepasswordValue = !obscurepasswordValue;
    });
  }

  toggleConfirmpasswordObscure() {
    setState(() {
      obscureConfirmpasswordValue = !obscureConfirmpasswordValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 20),
                child: _buildLogo(),
              ),
              SizedBox(
                height: 0,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                builder: (_, state) {
                  return ExpandablePageView(
                    controller: _controller,
                    children: [
                      _signIn(),
                      _signUp(),
                    ],
                  );
                },
                listener: (context, state) {
                  if (state is LoadingState) {
                    // CircularProgressIndicator.adaptive();
                    showLoaderDialog(context);
                  }
                  if (state is AuthSuccessState) {
                    widget._adapter.onAuthSuccess(context, service);
                  }
                  if (state is SignUpSuccessState) {
                    _controller.previousPage(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeOutQuad,
                    );
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
                    customSnackBar(context, state.message);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     backgroundColor: Colors.red,
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
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildLogo() => Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.asset(
              StaticAppImage.logo,
              height: 150,
            )
          ],
        ),
      );

  // _buildUI() => SingleChildScrollView(
  //       child: IntrinsicHeight(
  //         // height: 650,
  //         child: Container(
  //           height: 600,
  //           child: PageView(
  //               physics: NeverScrollableScrollPhysics(),
  //               controller: _controller,
  //               children: [
  //                 _signIn(),
  //                 _signUp(),
  //               ]),
  //         ),
  //       ),
  //     );

  _signIn() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Text("Welcome ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: primaryColor)),
              ),
              Divider(),
              SizedBox(
                height: 20.0,
              ),
              ..._emailAndPasword(),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
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
                    if (_email.isEmpty) {
                      customSnackBar(context, "Email $orgMessage");

                      return;
                    }
                    if (!checkEmail(_email)) {
                      customSnackBar(
                          context, "Please enter valid email address");

                      return;
                    }

                    if (_password.isEmpty || _password.length < 6) {
                      customSnackBar(context,
                          "Password $orgMessage and should be more than 6 characters long ");

                      return;
                    }

                    service = widget._manager.service(AuthType.emailPassword)!;

                    (service as EmailPassAuth)
                        .credentials(email: _email, password: _password);
                    var B = BlocProvider.of<AuthCubit>(context)
                        .signIn(service, AuthType.emailPassword);
                    log(B.toString());
                  },
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    height: 10,
                    thickness: 2,
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "OR",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    height: 10,
                    thickness: 2,
                  )),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
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
                  onPressed: () {
                    _controller.nextPage(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeOutQuart);
                  },
                  child: Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )),

              // SizedBox(
              //   height: 30,
              // ),
              // Container(
              //     padding: const EdgeInsets.only(top: 10, right: 20),
              //     color: Colors.grey.withOpacity(0.1),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Row(
              //           children: [
              //             Image.asset(
              //               'assets/images/logo.png',
              //               fit: BoxFit.cover,
              //               height: 70.0,
              //             ),
              //             Text(
              //               "Rastriya Samachar Samiti",
              //               style: TextStyle(
              //                 color: primaryColor,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   )
            ],
          ),
        ),
      );

  _signUp() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: Text("Register",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: primaryColor)),
            ),
            Divider(),
            SizedBox(height: 10.0),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => orgTypeCubit,
                ),
              ],
              child: BlocBuilder<OrgTypeCubit, OrgTypeState>(
                builder: (context, state) {
                  if (state is OrgTypeLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OrgTypeLoaded) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Select Organization Type :",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold),
                                // style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButton(
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                              alignment: Alignment.topLeft,
                              hint: Text(
                                "Select",
                                style: TextStyle(color: Colors.red),
                              ),
                              value: state.orgTypes[index],
                              items: state.orgTypes.map((item) {
                                _orgType = state.orgTypes[0].id;
                                log(_orgType.toString());
                                return new DropdownMenuItem(
                                  value: item,
                                  child: Row(children: <Widget>[
                                    Text(
                                      item.type_name!,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ]),
                                );
                              }).toList(),
                              isExpanded: true,
                              onChanged: (vas) async {
                                var va = vas as OrgType;
                                _orgType = va.id;
                                setState(() {
                                  index = state.orgTypes.indexOf(va);
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 10.0),
                          LoginSignUpForm(
                            keyboardType: TextInputType.text,
                            obscure: false,
                            inputAction: TextInputAction.next,
                            hint: 'Organization Name',
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                            onChanged: (val) {
                              _customer_org_name = val;
                            },
                          ),
                          SizedBox(height: 10.0),
                          ..._emailAndPasword(),
                          SizedBox(height: 10.0),
                          LoginSignUpForm(
                            keyboardType: TextInputType.text,
                            obscure: obscureConfirmpasswordValue,
                            inputAction: TextInputAction.next,
                            hint: 'Confirm Password',
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            onChanged: (val) {
                              _password_confirmation = val;
                            },
                            isSuffixrequires: true,
                            suffix: IconButton(
                              onPressed: toggleConfirmpasswordObscure,
                              icon: Icon(obscureConfirmpasswordValue
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height *
                                          0.054),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  backgroundColor: Color(0xff1F60BA),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4))),
                              child: Text(
                                "Sign Up",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                              ),
                              onPressed: () {
                                if (_customer_org_name.isEmpty) {
                                  customSnackBar(
                                      context, "Organization name $orgMessage");

                                  return;
                                }
                                if (_email.isEmpty) {
                                  customSnackBar(context, "Email $orgMessage");

                                  return;
                                }
                                if (!checkEmail(_email)) {
                                  customSnackBar(context,
                                      "Please enter valid email address");

                                  return;
                                }
                                if (_password.isEmpty || _password.length < 6) {
                                  customSnackBar(context,
                                      "Password $orgMessage and should be more than 6 characters long ");

                                  return;
                                }
                                if (_password_confirmation.isEmpty ||
                                    _password_confirmation.length < 6) {
                                  customSnackBar(context,
                                      "Password $orgMessage and should be more than 6 characters long ");

                                  return;
                                }
                                if (_password != _password_confirmation) {
                                  customSnackBar(
                                      context, "Please confirm your password ");

                                  return;
                                }

                                service = widget._manager
                                    .service(AuthType.emailPassword)!;
                                (service as EmailPassAuth).credentials(
                                  email: _email,
                                  password: _password,
                                  password_confirmation: _password_confirmation,
                                  customer_org_name: _customer_org_name,
                                  organization_type_id: _orgType,
                                );
                                BlocProvider.of<AuthCubit>(context)
                                    .signUp(service, AuthType.emailPassword);
                              }),

                          // CustomRaisedButton(
                          //   text: 'Sign up',
                          //   size: Size(double.infinity, 54.0),
                          //   onPressed: () {
                          //     if (_customer_org_name.isEmpty) {
                          //       customSnackBar(
                          //           context, "Organization name $orgMessage");

                          //       return;
                          //     }
                          //     if (_email.isEmpty) {
                          //       customSnackBar(context, "Email $orgMessage");

                          //       return;
                          //     }
                          //     if (!checkEmail(_email)) {
                          //       customSnackBar(context,
                          //           "Please enter valid email address");

                          //       return;
                          //     }
                          //     if (_password.isEmpty || _password.length < 6) {
                          //       customSnackBar(context,
                          //           "Password $orgMessage and should be more than 6 characters long ");

                          //       return;
                          //     }
                          //     if (_password_confirmation.isEmpty ||
                          //         _password_confirmation.length < 6) {
                          //       customSnackBar(context,
                          //           "Password $orgMessage and should be more than 6 characters long ");

                          //       return;
                          //     }
                          //     if (_password != _password_confirmation) {
                          //       customSnackBar(
                          //           context, "Please confirm your password ");

                          //       return;
                          //     }

                          //     service = widget._manager
                          //         .service(AuthType.emailPassword)!;
                          //     (service as EmailPassAuth).credentials(
                          //       email: _email,
                          //       password: _password,
                          //       password_confirmation: _password_confirmation,
                          //       customer_org_name: _customer_org_name,
                          //       organization_type_id: _orgType,
                          //     );
                          //     BlocProvider.of<AuthCubit>(context)
                          //         .signUp(service, AuthType.emailPassword);
                          //   },
                          //   color: Colors.blue,
                          // ),
                          // SizedBox(height: 30.0),
                          SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              text: 'Already have an account?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              children: [
                                TextSpan(
                                  text: ' Sign in',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _controller.previousPage(
                                        duration: Duration(milliseconds: 1000),
                                        curve: Curves.easeOutQuad,
                                      );
                                    },
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          //                SizedBox(
                          //   height: 30,
                          // ),
                          // Container(
                          //     padding: const EdgeInsets.only(top: 10, right: 20),
                          //     color: Colors.grey.withOpacity(0.1),
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Row(
                          //           children: [
                          //             Image.asset(
                          //               'assets/images/logo.png',
                          //               fit: BoxFit.cover,
                          //               height: 70.0,
                          //             ),
                          //             Text(
                          //               "Rastriya Samachar Samiti",
                          //               style: TextStyle(
                          //                 color: primaryColor,
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   )
                        ],
                      ),
                    );
                  } else if (state is OrgTypeError) {
                    return Center(
                      child: Text(state.errorType.toString()),
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      );

  List<Widget> _emailAndPasword() => [
        CustomTextField(
          keyboardType: TextInputType.emailAddress,
          inputAction: TextInputAction.next,
          hint: 'Email',
          obscure: false,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          onChanged: (val) {
            _email = val;
          },
        ),
        SizedBox(height: 20.0),
        CustomTextField(
            keyboardType: TextInputType.text,
            obscure: obscurepasswordValue,
            inputAction: TextInputAction.done,
            hint: 'Password',
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            onChanged: (val) {
              _password = val;
            },
            suffix: IconButton(
              onPressed: togglepasswordObscure,
              icon: Icon(obscurepasswordValue
                  ? Icons.visibility_off
                  : Icons.visibility),
            ),
            isSuffixrequires: true),
      ];
  _showLoader() {
    var alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      content: Container(
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

  void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Please wait...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
