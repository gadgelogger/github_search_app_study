import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:github_search_app_study/components/detail_row.dart';

import '../screens/search_screen.dart';
import '../services/github_service.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:github_search_app_study/constants/color_constants.dart';

class RepositoryList extends StatelessWidget {
  final String open;
  final DateFormat outputFormat;
  final String make;
  final String update;

  const RepositoryList({
    Key? key,
    required this.open,
    required this.outputFormat,
    required this.make,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (_, provider, __) {
        return ListView.builder(
          itemCount:
              provider.repositories.length + (provider.isLoadingMore ? 1 : 0),
          itemBuilder: (_, index) {
            if (index < provider.repositories.length) {
              final repository = provider.repositories[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6.0),
                    child: ExpansionTileCard(
                      leading: ClipOval(
                        child: Image.network(
                          repository.ownerIconUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        repository.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? ColorConstants.textLight
                                    : ColorConstants.textDark),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star_border,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? ColorConstants.iconLight
                                      : ColorConstants.iconDark),
                              Text(
                                '${repository.stars}',
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? ColorConstants.textLight
                                        : ColorConstants.textDark),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 10.0,
                                height: 10.0,
                                decoration: BoxDecoration(
                                  color: ColorConstants.boxDecoration,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                repository.language,
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? ColorConstants.textLight
                                      : ColorConstants.textDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Divider(
                          height: 1.0,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? ColorConstants.dividerLight
                                  : ColorConstants.dividerDark,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: DetailRow(
                                  iconData: Icons.remove_red_eye,
                                  text: '${repository.watchers} watchers',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: DetailRow(
                                  iconData: Icons.call_split,
                                  text: '${repository.forks} forks',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: DetailRow(
                                  iconData: Icons.report_problem,
                                  text: '${repository.issues} issues',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: DetailRow(
                                  iconData: Icons.book_rounded,
                                  text: repository.license,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: DetailRow(
                                  iconData: Icons.access_time,
                                  text:
                                      '${outputFormat.format(repository.createdAt)}$make',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: DetailRow(
                                  iconData: Icons.access_time,
                                  text:
                                      '${outputFormat.format(repository.updatedAt)}$update',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: DetailRow(
                                  iconData: Icons.person,
                                  text: repository.ownerName,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FloatingActionButton.extended(
                                      onPressed: () async {
                                        String url = repository.htmlUrl;
                                        if (await canLaunchUrl(
                                            Uri.parse(url))) {
                                          await launchUrl(
                                            Uri.parse(url),
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        } else {
                                          throw Webview(url);
                                        }
                                      },
                                      label: Text(
                                        open,
                                        style: TextStyle(
                                            color: ColorConstants.textDark),
                                      ),
                                      icon: Icon(Icons.open_in_new_outlined,
                                          color: ColorConstants.textDark),
                                      backgroundColor: Theme.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? ColorConstants.rowBackgroundLight
                                          : ColorConstants.rowBackgroundDark),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (provider.isLoadingMore) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}
