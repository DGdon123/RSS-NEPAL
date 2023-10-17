import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController? videoPlayerController;
  final bool? looping;

  ChewieListItem({
    required this.videoPlayerController,
    this.looping,
    Key? key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      autoPlay: false,
      videoPlayerController: widget.videoPlayerController!,
      looping: widget.looping!,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();

    widget.videoPlayerController!.dispose();

    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null && widget.videoPlayerController != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chewie(
              controller: _chewieController!,
            ),
          )
        : Text("Loading");
  }
}
