import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rss/domain/entities/news/all_news_entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rss/di/get_it.dart';
import 'package:rss/presentation/state_management/news/all_news/cubit/all_news_cubit.dart';

class AllNewListPage extends StatefulWidget {
  final List<AllNewsEntity> allNews;
  AllNewListPage({Key? key, required this.allNews}) : super(key: key);

  @override
  State<AllNewListPage> createState() => _AllNewListPageState();
}

class _AllNewListPageState extends State<AllNewListPage> {
  late AllNewsCubit allNewsCubit;

  @override
  void initState() {
    super.initState();
    allNewsCubit = getItInstance<AllNewsCubit>();
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
          allNewsCubit.fetchAllNews();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    allNewsCubit.fetchAllNews();
    return Expanded(
      child: Container(
        height: 200.h,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListView.builder(
            itemCount: widget.allNews.length,
            itemBuilder: (context, int index) {
              return Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(4, 4),
                            blurRadius: 5,
                            color: Colors.blueAccent.withOpacity(0.8)),
                      ]),
                  child: _newsList());
            },
          ),
        ]),
      ),
    );
  }

  Widget _newsList() {
    return BlocBuilder<AllNewsCubit, AllNewsState>(builder: (context, state) {
      if (state is AllNewsLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }

      if (state is AllNewsError) {
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
      List<AllNewsEntity> news = [];
      bool isLoading = false;

      if (state is AllNewsLoading) {
        news = state.oldNews;
        isLoading = true;
      } else if (state is AllNewsLoaded) {
        news = state.allNews;
      }

      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < news.length)
            return _news(news[index], context);
          else {
            Timer(Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });

            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: news.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _news(AllNewsEntity news, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 5,
            color: Colors.blueAccent.withOpacity(0.8),
          ),
        ],
      ),
      child: ListTile(
        leading: const Icon(Icons.album),
        minVerticalPadding: 10,
        title: Text('${news.dateLine.toString()} : ${news.title.toString()}'),
        subtitle: Text(
          news.subject.toString(),
        ),
      ),
    );
  }
}
