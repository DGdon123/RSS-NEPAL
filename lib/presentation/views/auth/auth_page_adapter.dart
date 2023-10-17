import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:rss/compostion_root.dart';
import 'package:rss/presentation/views/auth/check_credentials.dart';

abstract class IAuthPageAdapter {
  void onAuthSuccess(BuildContext context, IAuthService authService);
  void onSignUpSuccess(BuildContext context, IAuthService signUpService);
}

class AuthPageAdapter extends IAuthPageAdapter {
  AuthPageAdapter({required this.onUserAuthenticated});
  final Widget Function(IAuthService authService) onUserAuthenticated;

  @override
  void onAuthSuccess(BuildContext context, IAuthService authService) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => CheckCreditalsPage()),
        (Route<dynamic> route) => false);
  }

  @override
  void onSignUpSuccess(BuildContext context, IAuthService signUpService) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => CompositionRoot.composeAuthUI()),
        (Route<dynamic> route) => false);
  }
}
