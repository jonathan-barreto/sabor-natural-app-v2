import 'package:flutter/material.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';

class BottomModalCustom extends StatefulWidget {
  final Widget child;

  const BottomModalCustom({
    super.key,
    required this.child,
  });

  @override
  State<BottomModalCustom> createState() => _BottomModalCustomState();
}

class _BottomModalCustomState extends State<BottomModalCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            15,
          ),
          topRight: Radius.circular(
            15,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {},
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 8.0,
                    width: 64.0,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColorText,
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
