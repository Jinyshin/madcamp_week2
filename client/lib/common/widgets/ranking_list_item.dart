import 'package:client/common/const/app_colors.dart';
import 'package:flutter/material.dart';

class RankingListItem extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final int rank;
  final int score;

  const RankingListItem({
    required this.title,
    required this.onTap,
    required this.rank,
    required this.score,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '$rank',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(title),
                  onTap: onTap,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '$score',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: AppColors.faintGray.withOpacity(0.3)),
        ],
      ),
    );
  }
}
