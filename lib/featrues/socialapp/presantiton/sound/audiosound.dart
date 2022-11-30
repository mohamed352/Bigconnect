import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';

Future<void> playLoadingAudio(context) async {
  final audioplayer = AudioPlayer();
  final player = AudioCache(prefix: 'assets/audio/');
  final url = await player.load('loading.mp3');
  audioplayer.setSourceUrl(url.path);
  audioplayer.play(AssetSource('audio/loading.mp3'));
  SocialappCubit.get(context).ispostloading = false;
  Navigator.of(context).pop();
}

Future<void> playLoadingAudioComment(
    context, TextEditingController commenControler) async {
  final audioplayer = AudioPlayer();
  final player = AudioCache(prefix: 'assets/audio/');
  final url = await player.load('loading.mp3');
  audioplayer.setSourceUrl(url.path);
  audioplayer.play(AssetSource('audio/loading.mp3'));
  SocialappCubit.get(context).commentimage = null;
  commenControler.text = '';
  SocialappCubit.get(context).iscommentloading = false;
}

Future<void> playLikeSound() async {
  final audioplayer = AudioPlayer();
  final player = AudioCache(prefix: 'assets/audio/');
  final url = await player.load('like.mp3');
  audioplayer.setSourceUrl(url.path);
  audioplayer.play(AssetSource('audio/like.mp3'));
}
Future<void> playLoadingAudioEdit(context) async {
  final audioplayer = AudioPlayer();
  final player = AudioCache(prefix: 'assets/audio/');
  final url = await player.load('loading.mp3');
  audioplayer.setSourceUrl(url.path);
  audioplayer.play(AssetSource('audio/loading.mp3'));
  SocialappCubit.get(context).ispostloading = false;
  Navigator.of(context).pop();
  showSnackBar(
            context: context,
            text: 'Edit post compelet',
          );
}
