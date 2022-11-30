import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchControaler = TextEditingController();
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {
        if (state is SearchDone) {
          searchControaler.text = '';
        }
      },
      builder: (context, state) {
        var cubit = SocialappCubit.get(context);

        return GestureDetector(
          onVerticalDragUpdate: (d) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            
            child: Scaffold(
                body: Conditional.single(
              context: context,
              conditionBuilder: (context) => cubit.usermodel != null,
              widgetBuilder: (context) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 3),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.arrow_back_sharp,
                                  size: 30,
                                ),
                              ),
                            ),
                            Container(
                                height: 35,
                                padding: EdgeInsets.zero,
                                // margin: const EdgeInsets.symmetric(horizontal: 5),
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: TextFormField(
                                  controller: searchControaler,
                                  enableSuggestions: true,
                                  onFieldSubmitted: (value) {
                                    cubit.getsearch(searchControaler.text);
                                    // cubit.changeuser();
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                        height: 0.6,
                                        color: cubit.isdark == false
                                            ? Colors.grey
                                            : Colors.white),
                                    filled: true,
                                    fillColor: cubit.isdark == false
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade800,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            style: BorderStyle.none)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            style: BorderStyle.none)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            style: BorderStyle.none)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            style: BorderStyle.none)),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        color: cubit.isdark == false
                            ? Colors.grey.shade300
                            : Colors.grey.shade800,
                        height: 2,
                        width: double.infinity,
                        margin: const EdgeInsets.all(7),
                      ),
                      if (cubit.showuser && cubit.iserror == false)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text(
                                'Search Resault',
                                style: TextStyle(fontSize: 15),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    cubit.changeuser();
                                  },
                                  child: const Text(
                                    'Clear',
                                    style: TextStyle(
                                        fontSize: 13, color: AppColors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (cubit.showuser && cubit.iserror == false)
                        ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return buildsearchitem(
                                context,
                                index,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 13,
                                ),
                            itemCount: cubit
                                .snap!.docs.length), //cubit.snap!.docs.length),
                      if (cubit.iserror)
                        Center(
                            child: LottieBuilder.asset(AppImageAssets.empty1))
                    ],
                  ),
                );
              },
              fallbackBuilder: (context) => Center(
                  child: LottieBuilder.asset(AppImageAssets.loading)),
            )),
          ),
        );
      },
    );
  }

  Widget buildsearchitem(
    context,
    index,
  ) {
    var cubit = SocialappCubit.get(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(SlideLeft(
            page: ProfileScreen(
          otheruid: cubit.snap!.docs[index].data()['uid'],
        )));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage:
                NetworkImage(cubit.snap!.docs[index].data()['image']),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cubit.snap!.docs[index].data()['name'],
                style: const TextStyle(
                  height: 0.8,
                ),
              ),
              Text(
                cubit.snap!.docs[index].data()['bio'],
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ],
      ),
    );
  }
}
