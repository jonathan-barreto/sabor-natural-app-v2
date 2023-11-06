import 'package:flutter/material.dart';
import 'package:natural_app/src/features/home/widgets/column_texts.dart';
import 'package:natural_app/src/helpers/colors/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            const ColumnTexts(),
            CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: const Text('JB'),
            ),
          ],
        ),
      ),
    );
  }
}
