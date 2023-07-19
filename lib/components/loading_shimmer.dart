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
            ? ColorConstants.shimmer_baseColor_dark
            : ColorConstants.shimmer_baseColor_light,
        highlightColor: isDarkMode
            ? ColorConstants.shimmer_highlightColor_dark
            : ColorConstants.shimmer_highlightColor_light,
        child: ListTile(
          leading: ClipOval(
            child: Container(
                width: 50,
                height: 50,
                color: ColorConstants.shimmer_Container_color),
          ),
          title: SizedBox(
            height: 20,
            child: DecoratedBox(
              decoration:
                  BoxDecoration(color: ColorConstants.shimmer_ClipOval_color),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ColorConstants.shimmer_sizebox_color,
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Icon(Icons.star_border,
                      color: ColorConstants.shimmer_icon_color),
                  SizedBox(
                    width: 50.0,
                    height: 10.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorConstants.shimmer_sizebox_color,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                      width: 10.0,
                      height: 10.0,
                      color: ColorConstants.shimmer_Container_color),
                  const SizedBox(width: 5.0),
                  SizedBox(
                    width: 100.0,
                    height: 10.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorConstants.shimmer_sizebox_color,
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
