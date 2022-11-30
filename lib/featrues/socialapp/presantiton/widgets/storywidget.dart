import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:socialapp/featrues/socialapp/data/models/storymodel.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/profilestorywidget.dart';
import 'package:story_view/story_view.dart';

class StoryWdget extends StatefulWidget {
  final Story model;
  final PageController pagecontroller;
  final List<Story> storylist;

  final int index;
  const StoryWdget({
    super.key,
    required this.model,
    required this.pagecontroller,
    required this.storylist,
    required this.index,
  });

  @override
  State<StoryWdget> createState() => _StoryWdgetState();
}

class _StoryWdgetState extends State<StoryWdget> {
  StoryController controller = StoryController();
  List<StoryItem> storyItem = [];
  dynamic date;
  SystemUiOverlayStyle currentStyle = SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.black,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  );

  @override
  void initState() {
    super.initState();
    initStoryPageItem();
    controller = StoryController();
    date = widget.model.datatime;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handlecompelet() {
    widget.pagecontroller.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    final currentindex = widget.storylist.indexOf(widget.model);
    final islastpage = widget.storylist.length - 1 == currentindex;
    if (islastpage) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) => storyItem.isNotEmpty,
      widgetBuilder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: currentStyle,
          child: Stack(
            children: [
              Material(
                type: MaterialType.transparency,
                child: StoryView(
                  storyItems: storyItem,
                  controller: controller,
                  onComplete: handlecompelet,
                  inline: true,
                  onVerticalSwipeComplete: (direction) {
                    if (direction == Direction.down) {
                      Navigator.of(context).pop();
                    }
                  },
                  onStoryShow: (storyItems) {
                    final index = storyItem.indexOf(storyItems);
                    if (index > 0) {
                      setState(() {
                        date = widget.model.times[index];
                      });
                    }
                  },
                ),
              ),
              ProfileStoryWidget(
                model: widget.model,
                date: date,
                index: widget.index,
              ),
            ],
          ),
        );
      },
      fallbackBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
    );
  }

  void initStoryPageItem() {
    {
      for (int i = 0; i < widget.model.storyimage.length; i++) {
        storyItem.add(StoryItem.pageImage(
          url: widget.model.storyimage[i],
          controller: controller,
          caption:
              widget.model.capiton.length > i ? widget.model.capiton[i] : null,
        ));
      }
    }
  }
}
