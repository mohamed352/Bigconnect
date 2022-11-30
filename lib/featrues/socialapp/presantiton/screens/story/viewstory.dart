import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/data/models/storymodel.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/storywidget.dart';

// ignore: must_be_immutable
class ViewStory extends StatefulWidget {
  final Story model;
  final List<Story> storylist;
  final int index;
  const ViewStory(
      {super.key,
      required this.model,
      required this.index,
      required this.storylist});

  @override
  State<ViewStory> createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {
  PageController? pagecontroller;
  @override
  void initState() {
    super.initState();

    // final iniatlpage = widget.storylist.indexOf(widget.model);
    pagecontroller = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    pagecontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 

     PageView(
        controller: pagecontroller,

        // scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: widget.storylist
            .map((e) => StoryWdget(
                  model: e,
                  pagecontroller: pagecontroller!,
                  storylist: widget.storylist,
                  index: widget.index,
                ))
            .toList());
  }
}
