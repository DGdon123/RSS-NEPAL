import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/common/constants/strings.dart';
import 'package:rss/data/cache/auth/auth_local_store_contract.dart';
import 'package:rss/di/get_it.dart';
import 'package:rss/presentation/state_management/news/news_modules/news_modules_cubit.dart';
import 'package:rss/presentation/state_management/news/recent_news/cubit/recent_news_cubit.dart';
import 'package:rss/presentation/views/dashboard/news_modules_page.dart';
import 'package:rss/presentation/views/dashboard/recent_news.dart';
import 'package:rss/presentation/widgets/recent_news_shimmer.dart';
import 'package:rss/presentation/widgets/shimmer.dart';

import '../../../common/constants/appfonts_const.dart';
import 'app_drawer.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  late RecentNewsCubit recentNewsCubit;
  late NewsModulesCubit newsModulesCubit;
  late IAuthLocalStore store;

  @override
  void initState() {
    super.initState();
    recentNewsCubit = getItInstance<RecentNewsCubit>();
    newsModulesCubit = getItInstance<NewsModulesCubit>();
    recentNewsCubit.fetchRecentNews();
    store = getItInstance<IAuthLocalStore>();

    newsModulesCubit.fetchNewsModules();
  }

  @override
  void dispose() {
    super.dispose();
    recentNewsCubit.close();
    newsModulesCubit.close();
  }

  getRecentNew() {
    recentNewsCubit.fetchRecentNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawer(store: store),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => recentNewsCubit,
          ),
          BlocProvider(
            create: (context) => newsModulesCubit,
          ),
        ],
        child: FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<NewsModulesCubit, NewsModulesState>(
                  builder: (context, state) {
                if (state is NewsModulesLoading) {
                  return Shim();
                } else if (state is NewsModulesLoaded) {
                  return NewsModulesPage(newsModules: state.newsModules);
                } else if (state is NewsModulesError) {
                  return Center(
                    child: Text(state.errorType.toString()),
                  );
                }

                return SizedBox();
              }),
              BlocBuilder<RecentNewsCubit, RecentNewsState>(
                builder: (context, state) {
                  if (state is RecentNewsLoading) {
                    return RecentNewsShim();
                  } else if (state is RecentNewsLoaded) {
                    return RecentNewListPage(
                        cubit: BlocProvider.of<RecentNewsCubit>(context),
                        recentNews: state.recentNews);
                  } else if (state is RecentNewsError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Your Subscription has Expired. \nPlease contact your Admin.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 1.48,
                                fontSize: 16.0,
                                color: CupertinoColors.black,
                                fontFamily: AppFont.lProductsanfont),
                          ),
                        ),
                        SizedBox(
                          height: 26.5,
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget));
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
                  return SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
