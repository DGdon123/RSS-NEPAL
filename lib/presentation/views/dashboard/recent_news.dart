import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rss/common/constants/strings.dart';
import 'package:rss/domain/entities/news/recent_news_entities.dart';
import 'package:rss/presentation/views/news/all_news.dart';
import 'package:rss/presentation/views/news_details/news_details.dart';

import '../../../common/constants/static_image_constants.dart';

class RecentNewListPage extends StatefulWidget {
  final List<RecentNewsEntity> recentNews;
  final cubit;
  const RecentNewListPage(
      {Key? key, required this.recentNews, required this.cubit})
      : super(key: key);

  @override
  State<RecentNewListPage> createState() => _RecentNewListPageState();
}

class _RecentNewListPageState extends State<RecentNewListPage> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    // TODO: implement initState
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    super.initState();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(": ");
  }

  int audioIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       IconButton(
            //           onPressed: () async {
            //             if (isPlaying) {
            //               await audioPlayer.pause();
            //             } else {
            //               await audioPlayer.play(
            //                   "https://podcast.merolagani.com/media/2023-01-24_24_january_2023.mp3?fbclid=IwAR1lL3L9W0Cta77nOl4J_JXE9t0X2TAkoMju2Zy5JD106Tq-ir4iMxxkVuo");
            //             }
            //           },
            //           icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow)),
            //       SizedBox(
            //         width: 10.0,
            //       ),
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "s",
            //               style: TextStyle(color: Colors.black, fontSize: 12),
            //             ),
            //             // Slider(
            //             //     min: 0,
            //             //     max: duration
            //             //         .inSeconds
            //             //         .toDouble(),
            //             //     value: position
            //             //         .inSeconds
            //             //         .toDouble(),
            //             //     onChanged:
            //             //         (value) async {

            //             //     }),

            //             // Slider(
            //             //     min: 0,
            //             //     max: duration
            //             //         .inSeconds
            //             //         .toDouble(),
            //             //     value: position
            //             //         .inSeconds
            //             //         .toDouble(),
            //             //     onChanged:
            //             //         (value) async {
            //             //       final position =
            //             //           Duration(seconds: value.toInt());
            //             //       await audioPlayer
            //             //           .seek(position);
            //             //       await audioPlayer
            //             //           .resume();
            //             //     }),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 Text(
            //                   formatTime(position),
            //                   style: TextStyle(color: Colors.black),
            //                 ),
            //                 Text(formatTime(duration - position),
            //                     style: TextStyle(color: Colors.black))
            //               ],
            //             )
            //           ],
            //         ),
            //       ),

            //     ],
            //   ),
            // ),
            //Krishan sir helf
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 0, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent News",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      TextButton(
                          child: Text(
                            'View All',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    decoration: TextDecoration.underline),
                          ),
                          onPressed: (() {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => AllNewsPage(),
                              ),
                            );
                          }))
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  widget.cubit.fetchRecentNews();
                },
                child: ListView.builder(
                  itemCount: widget.recentNews.length,
                  itemBuilder: (context, int index) {
                    var data = widget.recentNews[index];
                    var dataLine = widget.recentNews[index].dateLine.toString();
                    var title = widget.recentNews[index].title.toString();
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
                              builder: (context) => NewsDetailsPage(
                                  id: widget.recentNews[index].id!),
                            ),
                          );
                        },
                        leading: Container(
                          width: 50,
                          height: 50,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                        title: Text('$dataLine: $title',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 11)),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                widget.recentNews[index].subject ??
                                    "".toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11)),
                            Row(
                              children: [
                                Icon(Icons.calendar_month),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                    widget.recentNews[index].newsDate ??
                                        "".toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 11)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
