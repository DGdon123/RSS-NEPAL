import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/utils/theme copy.dart';

class RessApp extends StatelessWidget {
  final Widget startPage;
  const RessApp(this.startPage);

  @override
  Widget build(BuildContext context) {
    final theme = NewsAppTheme.light();
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (BuildContext context,child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RSS',
        theme: theme,
        home: startPage,
      ),
    );
  }
}
