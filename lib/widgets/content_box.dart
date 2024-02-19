import 'package:flutter/material.dart';

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
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).colorScheme.onSurface),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 20),
          child, // Используем переданный child
        ],
      ),
    );
  }
}
