import 'dart:developer';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rss/di/get_it.dart';
import 'package:rss/presentation/state_management/news/news_details/news_details_cubit.dart';
import 'package:rss/presentation/views/news_details/news.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../common/constants/static_image_constants.dart';
import '../../widgets/custom_tile.dart';
import 'video_list.dart';

class NewsDetailsPage extends StatefulWidget {
  const NewsDetailsPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  VideoPlayerController? _videoPlayerController;
  VideoPlayerController? _newvideoPlayerController;
  ChewieController? chewieController;
  bool startedPlaying = false;
  bool isClicked = false;

  late NewsDetailsCubit newsDetailsCubit;
  String currentTitle = "";
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  // AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  // bool isPlaying = false;
  // String currentAudio = "";
  // IconData btnIcon = Icons.play_arrow;
  // Duration duration = Duration();
  // Duration position = Duration();

  // final player = AudioPlayer();
  // bool isaudioPlaying = false;
  // void playMusic(String url) async {
  //   if (isPlaying && currentAudio != url) {
  //     audioPlayer.pause();
  //     int result = await audioPlayer.play(url);
  //     if (result == 1) {
  //       setState(() {
  //         currentAudio = url;
  //       });
  //     }
  //   } else if (!isPlaying) {
  //     int result = await audioPlayer.play(url);
  //     if (result == 1) {
  //       setState(() {
  //         isPlaying = true;
  //       });
  //     }
  //   }
  //   audioPlayer.onDurationChanged.listen((event) {
  //     setState(() {
  //       duration = event;
  //     });
  //   });
  //   audioPlayer.onAudioPositionChanged.listen((event) {
  //     setState(() {
  //       position = event;
  //     });
  //   });
  // }

  var news;

  @override
  void initState() {
    // _videoPlayerController = VideoPlayerController.network(
    //     "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4");
    // _videoPlayerController?.initialize().then((_) {
    //   chewieController =
    //       ChewieController(videoPlayerController: _newvideoPlayerController!);
    //   setState(() {});
    // });
    super.initState();
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

    _requestPermission();
    newsDetailsCubit = getItInstance<NewsDetailsCubit>();
    newsDetailsCubit.fetchNewsDetails(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
    newsDetailsCubit.close();
    _videoPlayerController!.dispose();
    _newvideoPlayerController!.dispose();
    chewieController!.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController!.initialize();
    await _videoPlayerController!.play();
    startedPlaying = false;
    return true;
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
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
            body: MultiBlocProvider(
                providers: [
              BlocProvider(
                create: (context) => newsDetailsCubit,
              ),
            ],
                child: FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: 1,
                  child: BlocBuilder<NewsDetailsCubit, NewsDetailsState>(
                      builder: (context, state) {
                    if (state is NewsDetailsLoading) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 14,
                                ),
                                Text("Loading..."),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (state is NewsDetailsLoaded) {
                      // log(state.newsDetails.data!.newsMedia!.image!.length
                      //     .toString());
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                            child: AppBar(
                              bottom: TabBar(
                                indicatorColor: Colors.amberAccent,
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: [
                                  Tab(
                                      icon: Text(
                                    'News',
                                    style: GoogleFonts.poppins(),
                                  )),
                                  Tab(
                                      icon: Text('Images',
                                          style: GoogleFonts.poppins())),
                                  Tab(
                                      icon: Text('Videos',
                                          style: GoogleFonts.poppins())),
                                  Tab(
                                      icon: Text('Audios',
                                          style: GoogleFonts.poppins())),
                                ],
                              ),
                              title: Text(
                                'News Details ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.84,
                            child: TabBarView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      NewsPage(newsDetails: state.newsDetails),
                                ),
                                state.newsDetails.data!.newsMedia!.image!
                                        .isNotEmpty
                                    ? ListView.builder(
                                        itemCount: state.newsDetails.data!
                                            .newsMedia!.image!.length,
                                        // gridDelegate:
                                        //     SliverGridDelegateWithFixedCrossAxisCount(
                                        //         crossAxisCount: 2,
                                        //         crossAxisSpacing: 20,
                                        //         mainAxisSpacing: 20),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            // alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(4, 2),
                                                  blurRadius: 4,
                                                  color: Colors.blueAccent
                                                      .withOpacity(0.1),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state
                                                      .newsDetails
                                                      .data!
                                                      .newsMedia!
                                                      .image![index]
                                                      .media_title
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                    color: Colors.black,
                                                    height: 140,
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    alignment: Alignment.center,
                                                    child: CachedNetworkImage(
                                                        imageUrl: state
                                                            .newsDetails
                                                            .data!
                                                            .newsMedia!
                                                            .image![index]
                                                            .filePath
                                                            .toString(),
                                                        placeholder: (context, url) =>
                                                            CircleAvatar(
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        StaticAppImage
                                                                            .placeHolder)),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            CircleAvatar(
                                                                backgroundImage:
                                                                    AssetImage(StaticAppImage.placeHolder)))
                                                    // Image.network(
                                                    //   state
                                                    //       .newsDetails
                                                    //       .data!
                                                    //       .newsMedia!
                                                    //       .image![index]
                                                    //       .filePath
                                                    //       .toString(),
                                                    //   fit: BoxFit.fill,
                                                    //   loadingBuilder:
                                                    //       (BuildContext context,
                                                    //           Widget child,
                                                    //           ImageChunkEvent?
                                                    //               loadingProgress) {
                                                    //     if (loadingProgress == null)
                                                    //       return child;
                                                    //     return Center(
                                                    //       child:
                                                    //           CircularProgressIndicator(
                                                    //         value: loadingProgress
                                                    //                     .expectedTotalBytes !=
                                                    //                 null
                                                    //             ? loadingProgress
                                                    //                     .cumulativeBytesLoaded /
                                                    //                 loadingProgress
                                                    //                     .expectedTotalBytes!
                                                    //             : null,
                                                    //       ),
                                                    //     );
                                                    //   },
                                                    // ),
                                                    ),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            fixedSize: Size(
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.894,
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.0),
                                                            elevation: 0,
                                                            backgroundColor:
                                                                Color(
                                                                    0xff1F60BA),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4))),
                                                        onPressed: () async {
                                                          _save(
                                                            state
                                                                .newsDetails
                                                                .data!
                                                                .newsMedia!
                                                                .image![index]
                                                                .filePath
                                                                .toString(),
                                                            state.newsDetails
                                                                .data!.title
                                                                .toString(),
                                                          );
                                                        },
                                                        child: Text(
                                                          "Download",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                        )),
                                                    // MaterialButton(
                                                    //     color: Colors.blue,
                                                    //     child: Text(
                                                    //       "Download",
                                                    //       style: TextStyle(
                                                    //         color: Colors.white,
                                                    //       ),
                                                    //     ),
                                                    //     onPressed: () async {
                                                    //       _save(
                                                    //         state
                                                    //             .newsDetails
                                                    //             .data!
                                                    //             .newsMedia!
                                                    //             .image![index]
                                                    //             .filePath
                                                    //             .toString(),
                                                    //         state.newsDetails
                                                    //             .data!.title
                                                    //             .toString(),
                                                    //       );
                                                    //     }),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Text(
                                        "No image found!",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                state.newsDetails.data!.newsMedia!.video!
                                        .isNotEmpty
                                    ? Container(
                                        child: ListView.builder(
                                          itemCount: state.newsDetails.data!
                                              .newsMedia!.video!.length,
                                          // gridDelegate:
                                          //     SliverGridDelegateWithFixedCrossAxisCount(
                                          //   crossAxisCount: 1,
                                          // ),
                                          itemBuilder: (context, index) {
                                            log(state
                                                    .newsDetails
                                                    .data!
                                                    .newsMedia!
                                                    .video![index]
                                                    .media_title
                                                    .toString() +
                                                "Video");
                                            return Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(4, 4),
                                                    blurRadius: 1,
                                                    color: Colors.blueAccent
                                                        .withOpacity(0.1),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15, top: 10),
                                                    child: Text(
                                                      state
                                                          .newsDetails
                                                          .data!
                                                          .newsMedia!
                                                          .video![index]
                                                          .media_title
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    height: ScreenUtil
                                                            .defaultSize
                                                            .height /
                                                        3,
                                                    child:
                                                        // Chewie(
                                                        //     controller:
                                                        //         chewieController!),

                                                        // BetterPlayer.network(
                                                        //     "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")
                                                        ChewieListItem(
                                                      videoPlayerController:
                                                          VideoPlayerController
                                                              .network(state
                                                                  .newsDetails
                                                                  .data!
                                                                  .newsMedia!
                                                                  .video![index]
                                                                  .filePath
                                                                  .toString()),
                                                      looping: false,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            fixedSize: Size(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                    0.055),
                                                            elevation: 0,
                                                            padding: const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 30),
                                                            backgroundColor:
                                                                Color(
                                                                    0xff1F60BA),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(4))),
                                                        onPressed: () async {
                                                          _saveVideo(
                                                              state
                                                                  .newsDetails
                                                                  .data!
                                                                  .newsMedia!
                                                                  .video![index]
                                                                  .filePath
                                                                  .toString(),
                                                              state.newsDetails
                                                                  .data!.title
                                                                  .toString());
                                                        },
                                                        child: Text(
                                                          "Download",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                        )),
                                                  ),
                                                  // MaterialButton(
                                                  //   color: Colors.blue,
                                                  //   onPressed: () {},
                                                  //   child: Text(
                                                  //     "Download",
                                                  //     style: TextStyle(
                                                  //         color: Colors.white),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          "No Video found!",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                state.newsDetails.data!.newsMedia!.audio!
                                        .isNotEmpty
                                    ? Column(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount: state
                                                    .newsDetails
                                                    .data!
                                                    .newsMedia!
                                                    .audio!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  log(state
                                                      .newsDetails
                                                      .data!
                                                      .newsMedia!
                                                      .audio![index]
                                                      .filePath!);
                                                  return customListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        // btnIcon = Icons.pause;
                                                        isClicked = !isClicked;
                                                        currentTitle = state
                                                            .newsDetails
                                                            .data!
                                                            .title!;
                                                        audioIndex = index;
                                                      });
                                                      // // playMusic(currentTitle =
                                                      //     "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3");
                                                      // setState(() {

                                                      // });
                                                    },
                                                    title: state.newsDetails
                                                        .data!.title,
                                                  );
                                                }),
                                          ),
                                          isClicked
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (isPlaying) {
                                                                    await audioPlayer
                                                                        .pause();
                                                                  } else {
                                                                    await audioPlayer.play(state
                                                                        .newsDetails
                                                                        .data!
                                                                        .newsMedia!
                                                                        .audio![
                                                                            audioIndex]
                                                                        .filePath!);
                                                                  }
                                                                },
                                                                icon: Icon(isPlaying
                                                                    ? Icons
                                                                        .pause
                                                                    : Icons
                                                                        .play_arrow)),
                                                            SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    currentTitle,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  // Slider(
                                                                  //     min: 0,
                                                                  //     max: duration
                                                                  //         .inSeconds
                                                                  //         .toDouble(),
                                                                  //     value: position
                                                                  //         .inSeconds
                                                                  //         .toDouble(),
                                                                  //     onChanged:
                                                                  //         (value) async {

                                                                  //     }),

                                                                  // Slider(
                                                                  //     min: 0,
                                                                  //     max: duration
                                                                  //         .inSeconds
                                                                  //         .toDouble(),
                                                                  //     value: position
                                                                  //         .inSeconds
                                                                  //         .toDouble(),
                                                                  //     onChanged:
                                                                  //         (value) async {
                                                                  //       final position =
                                                                  //           Duration(seconds: value.toInt());
                                                                  //       await audioPlayer
                                                                  //           .seek(position);
                                                                  //       await audioPlayer
                                                                  //           .resume();
                                                                  //     }),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Text(
                                                                        formatTime(
                                                                            position),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                      Text(
                                                                          formatTime(duration -
                                                                              position),
                                                                          style:
                                                                              TextStyle(color: Colors.black))
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            // IconButton(
                                                            // onPressed: () {
                                                            //   if (isPlaying) {
                                                            //     audioPlayer
                                                            //         .pause();
                                                            //     setState(() {
                                                            //       btnIcon = Icons
                                                            //           .pause;
                                                            //       isPlaying =
                                                            //           false;
                                                            //     });
                                                            //   } else {
                                                            //     audioPlayer
                                                            //         .resume();
                                                            //     setState(
                                                            //       () {
                                                            //         btnIcon =
                                                            //             Icons
                                                            //                 .play_arrow;
                                                            //         isPlaying =
                                                            //             true;
                                                            //       },
                                                            //     );
                                                            //   }
                                                            // },
                                                            // iconSize: 42.0,
                                                            // icon: Icon(
                                                            //   btnIcon,
                                                            // ),
                                                            // }
                                                            // )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Text("")
                                        ],
                                      )
                                    : Center(
                                        child: Text(
                                          "No audio file found!",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (state is NewsDetailsError) {
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
                                      builder: (BuildContext context) =>
                                          super.widget));
                            },
                            child: Text(
                              "Refresh",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return SizedBox.shrink();
                  }),
                ))),
      ),
    );
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  _save(String url, String name) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      _showLoader("Downloading Image");
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
          quality: 60, name: name);
      _hideLoader();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Image Saved to gallery.",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white, fontSize: 16.0),
          ),
        ),
      );
    }
  }

  _saveVideo(String url, String name) async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      var appDocDir = await getTemporaryDirectory();
      String savePath = appDocDir.path + "/" + name + ".mp4";
      setState(() {
        _showLoader(
            "Downloading video \n It may take a while \n       Please wait... ");
      });
      await Dio().download(url, savePath, onReceiveProgress: (count, total) {});

      var result = await ImageGallerySaver.saveFile(savePath);
      print(result);
      _hideLoader();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Video Saved to gallery.",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white, fontSize: 16.0),
          ),
        ),
      );
    } else {
      _requestPermission();
    }
  }

  _showLoader(String message) {
    var alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
    showDialog(
        context: context, barrierDismissible: true, builder: (_) => alert);
  }

  _hideLoader() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
