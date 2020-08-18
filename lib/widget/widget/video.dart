import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Place the video as a widget.
///
/// A preview is also possible.
class Video extends StatefulWidget {
  /// Video URL and path.
  final String uri;

  /// Video file.
  final File file;

  /// True to loop the video.
  final bool loop;

  /// Horizontal size of the video.
  final double width;

  /// Vertical size of the video.
  final double height;

  /// Video fit.
  final BoxFit fit;

  /// True for auto play.
  final bool autoplay;

  /// True if it can be played and stopped.
  final bool controllable;

  /// True to mute.
  final bool mute;
  final _VideoType _type;

  /// Place the video as a widget.
  ///
  /// A preview is also possible.
  ///
  /// [path]: Asset path.
  /// [loop]: True to loop the video.
  /// [width]: Horizontal size of the video.
  /// [height]: Vertical size of the video.
  /// [fit]: Video fit.
  /// [autoplay]: True for auto play.
  /// [controllable]: True if it can be played and stopped.
  /// [mute]: True to mute.
  Video.asset(String path,
      {this.loop = true,
      this.width,
      this.height,
      this.fit,
      this.autoplay = false,
      this.mute = false,
      this.controllable = false})
      : this._type = _VideoType.asset,
        file = null,
        uri = path;

  /// Place the video as a widget.
  ///
  /// A preview is also possible.
  ///
  /// [file]: File objects.
  /// [loop]: True to loop the video.
  /// [width]: Horizontal size of the video.
  /// [height]: Vertical size of the video.
  /// [autoplay]: True for auto play.
  /// [controllable]: True if it can be played and stopped.
  /// [mute]: True to mute.
  /// [fit]: Video fit.
  Video.file(File file,
      {this.loop = true,
      this.width,
      this.height,
      this.fit,
      this.autoplay = false,
      this.mute = false,
      this.controllable = false})
      : this._type = _VideoType.file,
        file = file,
        uri = null;

  /// Place the video as a widget.
  ///
  /// A preview is also possible.
  ///
  /// [url]: Network urls.
  /// [loop]: True to loop the video.
  /// [width]: Horizontal size of the video.
  /// [height]: Vertical size of the video.
  /// [autoplay]: True for auto play.
  /// [controllable]: True if it can be played and stopped.
  /// [mute]: True to mute.
  /// [fit]: Video fit.
  Video.network(String url,
      {this.loop = true,
      this.width,
      this.height,
      this.fit,
      this.autoplay = false,
      this.mute = false,
      this.controllable = false})
      : this._type = _VideoType.network,
        file = null,
        uri = url;

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  Future _initializing;
  VideoPlayerController _controller;

  @override
  void initState() {
    switch (this.widget._type) {
      case _VideoType.file:
        _controller = VideoPlayerController.file(this.widget.file);
        break;
      case _VideoType.network:
        _controller = VideoPlayerController.network(this.widget.uri);
        break;
      default:
        _controller = VideoPlayerController.asset(this.widget.uri);
        break;
    }
    _initializing = _controller.initialize().then((value) {
      if (this.widget.autoplay) _controller.play();
    });
    _controller.setLooping(this.widget.loop);
    if (this.widget.mute) _controller.setVolume(0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializing,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (this.widget.width != null && this.widget.height != null) {
            return SizedBox(
                width: this.widget.width,
                height: this.widget.height,
                child: _videoWidget(context));
          } else if (this.widget.width != null) {
            return SizedBox(
                width: this.widget.width,
                height: this.widget.width / _controller.value.aspectRatio,
                child: _videoWidget(context));
          } else if (this.widget.height != null) {
            return SizedBox(
                width: this.widget.height * _controller.value.aspectRatio,
                height: this.widget.height,
                child: _videoWidget(context));
          } else {
            return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: _videoWidget(context));
          }
        } else {
          return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).disabledColor));
        }
      },
    );
  }

  Widget _videoWidget(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      (this.widget.fit == null)
          ? VideoPlayer(_controller)
          : FittedBox(
              fit: this.widget.fit,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              )),
      if (this.widget.controllable)
        Center(
          child: IconButton(
              icon: Icon(
                  _controller.value.isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  color: _controller.value.isPlaying
                      ? Colors.transparent
                      : Theme.of(context).backgroundColor),
              onPressed: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
                this.setState(() {});
              }),
        )
    ]);
  }
}

enum _VideoType { asset, file, network }
