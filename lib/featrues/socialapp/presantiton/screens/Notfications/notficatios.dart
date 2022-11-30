import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/notificationsitem.dart';

class NotficationsScrenn extends StatelessWidget {
  const NotficationsScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialappCubit.get(context);
        return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  if(cubit.notifid.isNotEmpty)
                  const Text(
                    'Earlier',
                    style: TextStyle(fontSize: 15),
                  ),
                 if(cubit.notifid.isNotEmpty)
                  const SizedBox(
                    height: 6,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildNotificationsitem(
                            cubit.notifications[index], context, index);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 6,),
                      itemCount: cubit.notifications.length)
                ],
              ),
                      ),
                    ),
            ));
      },
    );
  }
}
