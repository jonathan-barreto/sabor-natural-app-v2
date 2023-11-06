import 'package:flutter/material.dart';
import 'package:natural_app/src/features/home/widgets/profile_header.dart';
import 'package:natural_app/src/features/home/widgets/search_bar_custom.dart';

class UserProfileSearchList extends StatelessWidget {
  final SearchController controller;
  final void Function(String) updateParent;

  const UserProfileSearchList({
    super.key,
    required this.controller,
    required this.updateParent,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          color: Colors.white,
          child: Column(
            children: [
              const ProfileHeader(),
              SearchBarCustom(
                controller: controller,
                updateParent: (text) => controller.closeView(text),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
