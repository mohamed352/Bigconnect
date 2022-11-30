import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:socialapp/core/constant/loading.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/serach/serach.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/icon.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (BuildContext context, state) {
        if (SocialappCubit.get(context).currentindex == 1) {
          SocialappCubit.get(context).notifid = [];
        }
      },
      builder: (BuildContext context, state) {
        var cubit = SocialappCubit.get(context);
        var model = SocialappCubit.get(context).usermodel;

        TabController? tabController;

        return Conditional.single(
            context: context,
            conditionBuilder: (context) => cubit.userlist.isNotEmpty,
            widgetBuilder: (context) {
              return DefaultTabController(
                  length: 3,
                  initialIndex: cubit.currentindex,
                  child: Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        title: cubit.titles[cubit.currentindex],
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(AlignAnimationsRoute(
                                    page: const SearchScreen()));
                              },
                              icon: const Icon(IconBroken.search)),
                        ],
                        bottom: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          key: key,
                          controller: tabController,
                          automaticIndicatorColorAdjustment: true,
                          onTap: (index) {
                            cubit.changeindex(index);
                          },
                          labelColor: AppColors.blue,
                          enableFeedback: true,
                          unselectedLabelColor: Colors.grey.shade400,
                          tabs: [
                            Tab(
                              icon: Icon(
                                cubit.currentindex == 0
                                    ? Icons.home_sharp
                                    : Icons.home_outlined,
                                size: 28,
                              ),

                              // text: 'Home',
                            ),
                            Tab(
                              icon: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Icon(
                                    cubit.currentindex == 1
                                        ? Icons.notifications
                                        : Icons.notifications_active_outlined,
                                    size: 28,
                                  ),
                                  if (cubit.notifid.isNotEmpty)
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        '${cubit.notifid.length}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 14,
                                                height: 1.3),
                                      ),
                                    ),
                                ],
                              ),
                              // text: 'Notification',
                            ),
                            Tab(
                              icon: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: cubit.currentindex == 2
                                        ? Colors.blue
                                        : Colors.grey.shade500,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          NetworkImage('${model?.image}'),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: cubit.currentindex == 2
                                        ? Colors.blue
                                        : Colors.grey.shade500,
                                    child: const Icon(
                                      Icons.menu,
                                      size: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              // text: 'Menu',
                            ),
                          ],
                        ),
                      ),
                      body: IndexedStack(
                          index: cubit.currentindex, children: cubit.screens)));
            },
            fallbackBuilder: (BuildContext context) {
              return loading(context);
            });
      },
    );
  }
}
