import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/github_service.dart';
import 'package:github_search_app_study/constants/color_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final String search;

  const CustomAppBar({Key? key, required this.controller, required this.search})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    context.read<SearchProvider>().search(value);
                  },
                  decoration: InputDecoration(
                    hintText: search,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        controller.clear();
                        context.read<SearchProvider>().clear();
                      },
                    ),
                    filled: true,
                    fillColor: Theme.of(context).brightness == Brightness.light
                        ? ColorConstants.appBarColor_light
                        : ColorConstants.appBarColor_dark,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
