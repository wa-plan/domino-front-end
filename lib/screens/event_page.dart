import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  String domino =
      "50"; // Assume this variable will be populated via an API call
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/img/domino_1.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();

    // Listen for the end of the video
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        // Video has ended, stop the video
        _controller.pause();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(children: [
                          const TextSpan(
                            text: '드디어 도미노를\n쓰러뜨리는 날이에요.\n그동안 ',
                            style: TextStyle(
                              height: 2,
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: domino,
                            style: const TextStyle(
                              height: 2,
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const TextSpan(
                            text: '개의 도미노를\n모았어요.',
                            style: TextStyle(
                              height: 2,
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ])),
                        const SizedBox(height: 20),
                        const Text(
                          '준비 되셨나요?\n공을 굴려주세요!',
                          style: TextStyle(
                            height: 2,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
