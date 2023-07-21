import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:github_search_app_study/constants/color_constants.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: isDarkMode
            ? ColorConstants.shimmerBaseColorDark
            : ColorConstants.shimmerBaseColorLight,
        highlightColor: isDarkMode
            ? ColorConstants.shimmerHighlightColorDark
            : ColorConstants.shimmerHighlightColorLight,
        child: ListTile(
          leading: ClipOval(
            child: Container(
                width: 50,
                height: 50,
                color: ColorConstants.shimmerContainerColor),
          ),
          title: SizedBox(
            height: 20,
            child: DecoratedBox(
              decoration:
                  BoxDecoration(color: ColorConstants.shimmerClipOvalColor),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ColorConstants.shimmerSizeboxColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Icon(Icons.star_border,
                      color: ColorConstants.shimmerIconColor),
                  SizedBox(
                    width: 50.0,
                    height: 10.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorConstants.shimmerSizeboxColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                      width: 10.0,
                      height: 10.0,
                      color: ColorConstants.shimmerContainerColor),
                  const SizedBox(width: 5.0),
                  SizedBox(
                    width: 100.0,
                    height: 10.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorConstants.shimmerSizeboxColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
