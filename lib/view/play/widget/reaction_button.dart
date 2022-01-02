import 'package:flutter/material.dart';
import 'package:live_tv/common/enum/reaction.dart';

class ReactionButton extends StatelessWidget {
  final Function(Reaction) onTap;

  const ReactionButton({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(Reaction.values.length, (index) {
        final reaction = Reaction.values[index];
        return IconButton(
            onPressed: () => onTap(reaction), icon: reaction.icon);
      }),
    );
  }
}
