import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final double fontSize;
  final FontWeight fontWeight;
  final Function(String val) onChanged;
  final double height;
  final void Function(String)? onSubmitted;
  final TextInputAction inputAction;
  final TextInputType keyboardType;
  final bool obscure;
  bool isSuffixrequires;
  Widget? suffix;
  CustomTextField({
    required this.hint,
    required this.fontSize,
    required this.fontWeight,
    required this.onChanged,
    this.height = 50.0,
    this.onSubmitted,
    this.suffix,
    required this.inputAction,
    required this.keyboardType,
    required this.obscure,
    this.isSuffixrequires = false,
  });

  final _border = const OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.5,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscure,
          keyboardType: keyboardType,
          // onSubmitted: onSubmitted,
          onChanged: onChanged,
          textInputAction: inputAction,
          cursorColor: Colors.black,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: fontWeight, fontSize: 12),
          decoration: InputDecoration(
              fillColor: Colors.grey.withOpacity(0.2),
              filled: true,
              counterText: '',
              suffixIcon: isSuffixrequires ? suffix : null,
              contentPadding: EdgeInsets.all(16.0),
              hintText: hint,
              hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(1),
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xffF8FAFB),
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.red[700]!,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xffF8FAFB),
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ))),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   boxShadow: [
      //     BoxShadow(
      //       color: Theme.of(context).colorScheme.secondary,
      //       blurRadius: 9,
      //       offset: const Offset(5, 5),
      //     ),
      //   ],
      // ),
    );
  }
}

class LoginSignUpForm extends StatelessWidget {
  final String hint;
  final double fontSize;
  final FontWeight fontWeight;
  final Function(String val) onChanged;
  final double height;
  final void Function(String)? onSubmitted;
  final TextInputAction inputAction;
  final TextInputType keyboardType;
  final bool obscure;
  bool isSuffixrequires;
  Widget? suffix;
  final String? Function(String? value)? validator;
  LoginSignUpForm(
      {required this.hint,
      required this.fontSize,
      required this.fontWeight,
      required this.onChanged,
      this.height = 50.0,
      this.onSubmitted,
      this.suffix,
      required this.inputAction,
      required this.keyboardType,
      required this.obscure,
      this.isSuffixrequires = false,
      this.validator});

  final _border = const OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.5,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextFormField(
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscure,
          keyboardType: keyboardType,
          // onSubmitted: onSubmitted,
          onChanged: onChanged,
          textInputAction: inputAction,
          cursorColor: Colors.black,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: fontWeight,
            fontSize: 12,
            //  Theme.of(context).textTheme.overline!.copyWith(
          ),
          decoration: InputDecoration(
              fillColor: Colors.grey.withOpacity(0.2),
              filled: true,
              counterText: '',
              suffixIcon: isSuffixrequires ? suffix : null,
              contentPadding: EdgeInsets.all(16.0),
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.grey.withOpacity(1),
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xffF8FAFB),
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.red[700]!,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xffF8FAFB),
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ))),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   boxShadow: [
      //     BoxShadow(
      //       color: Theme.of(context).colorScheme.secondary,
      //       blurRadius: 9,
      //       offset: const Offset(5, 5),
      //     ),
      //   ],
      // ),
    );
  }
}
