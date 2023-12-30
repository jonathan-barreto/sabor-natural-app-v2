import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: DefaultContainer(
                        height: 100,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    DefaultContainer(
                      height: 100,
                      circleShape: true,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: DefaultContainer(
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: DefaultContainer(
                              height: 200,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: DefaultContainer(
                              height: 200,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: DefaultContainer(
                              height: 200,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: DefaultContainer(
                              height: 200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultContainer extends StatelessWidget {
  final double height;
  final bool circleShape;

  const DefaultContainer({
    super.key,
    required this.height,
    this.circleShape = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: height,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: circleShape ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
