import 'package:flutter/material.dart';
import 'package:miro/style/text_styles.dart';
import 'package:miro/style/colors.dart';

class ContentBox extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsets margin;

  const ContentBox({
    Key? key,
    required this.title,
    required this.child,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.contentBackground,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style:  TextStyles.h2Style),
          const SizedBox(height: 20),
          child, // Используем переданный child
        ],
      ),
    );
  }
}
