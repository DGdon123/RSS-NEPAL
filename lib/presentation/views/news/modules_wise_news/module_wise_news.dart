import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rss/di/get_it.dart';
import 'package:rss/domain/entities/news/all_news_entities.dart';
import 'package:rss/presentation/state_management/news/module_wise_news/cubit/module_wise_news_cubit.dart';
import 'package:rss/presentation/views/news_details/news_details.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/constants/static_image_constants.dart';
import '../../../../common/constants/strings.dart';

// ignore: must_be_immutable
class ModuleWiseNewsPage extends StatefulWidget {
  ModuleWiseNewsPage({Key? key, required this.id, required this.moduleName})
      : super(key: key);
  int id;
  String moduleName;

  @override
  _ModuleWiseNewsPageState createState() => _ModuleWiseNewsPageState();
}

class _ModuleWiseNewsPageState extends State<ModuleWiseNewsPage> {
  late ModuleWiseNewsCubit allNewsCubit;

  @override
  void initState() {
    super.initState();
    allNewsCubit = getItInstance<ModuleWiseNewsCubit>();
    allNewsCubit.fetchNewsByModule(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    allNewsCubit.close();
  }

  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          allNewsCubit.fetchNewsByModule(widget.id);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    allNewsCubit.fetchNewsByModule(widget.id);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(
                  widget.moduleName,
                ),
              ],
            ),
          ),
          // drawer: DrawerNavigation(),
          body: MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => allNewsCubit,
            ),
          ], child: _newsList())),
    );
  }

  Widget _newsList() {
    return BlocBuilder<ModuleWiseNewsCubit, ModuleWiseNewsState>(
        builder: (context, state) {
      if (state is ModuleWiseNewsLoading && state.isFirstFetch) {
        return Shim();
      }

      List<AllNewsEntity> news = [];
      bool isLoading = false;

      if (state is ModuleWiseNewsLoading) {
        news = state.oldNews;
        isLoading = true;
      } else if (state is ModuleWiseNewsLoaded) {
        news = state.moduleWiseNews;
      }

      return ListView.builder(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < news.length) {
            return _news(news[index], context);
          } else {
            Timer(Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });

            return _loadingIndicator();
          }
        },
        itemCount: news.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: CircularProgressIndicator()));
  }

  Widget _news(AllNewsEntity news, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 1,
            color: Colors.blueAccent.withOpacity(0.1),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => NewsDetailsPage(id: news.id!),
            ),
          );
        },
        leading: Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueAccent)),
          child: SvgPicture.asset(
            StaticAppImage.newsLogo,
            color: primaryColor,
            width: 30,
            height: 30,
          ),
        ),
        // Image.asset(
        //   'assets/images/new.gif',
        //   height: 15,
        // ),
        minVerticalPadding: 10,
        title: Text('${news.dateLine.toString()} : ${news.title.toString()}',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 11)),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(news.subject ?? "".toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 11)),
            Row(
              children: [
                Icon(Icons.calendar_month),
                SizedBox(
                  width: 4,
                ),
                Text(news.newsDate ?? "".toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.normal, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
    //    Container(
    // margin: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
    //     decoration: BoxDecoration(  boxShadow: [
    //                         BoxShadow(
    //                           offset: Offset(4, 4),
    //                           blurRadius: 1,
    //                           color: Colors.blueAccent.withOpacity(0.1),
    //                         ),
    //                       ],
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(5),
    //     ),
    //     child: ListTile(
    //               leading: Container(
    //                       padding: EdgeInsets.symmetric(vertical: 4,horizontal: 4),
    //                         decoration: BoxDecoration(
    //                            borderRadius: BorderRadius.circular(10),
    //                           border:   Border.all(color: Colors.blueAccent)),
    //                         child: Icon(Icons.feed,size: 35,)),
    //       minVerticalPadding: 10,
    //       title: Text('${news.dateLine.toString()} : ${news.title.toString()}',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight:FontWeight.w500,fontSize: 12)),
    //       subtitle: Text(
    //         news.subject??"".toString(),
    //       ),
    //       onTap: () {
    //         Navigator.push(
    //           context,
    //           new MaterialPageRoute(
    //             builder: (context) => NewsDetailsPage(id: news.id!),
    //           ),
    //         );
    //       },
    //     ),
    //   );
  }
}

class Shim extends StatelessWidget {
  const Shim({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        enabled: true,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 15,
        ),
      ),
    );
  }
}
