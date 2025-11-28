import 'package:flutter/material.dart';

import 'playlist_text.dart';

class PlayListTopTitleWidget extends StatelessWidget {
  const PlayListTopTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const PlayListText(),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          behavior: HitTestBehavior.opaque,
          child: const Icon(
            Icons.keyboard_arrow_down_outlined,
            // color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    );
  }
}
