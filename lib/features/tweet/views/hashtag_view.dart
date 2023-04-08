import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HashTagView extends ConsumerWidget {
  final String hashTag;

  const HashTagView({
    super.key,
    required this.hashTag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hashTag),
      ),
    );
  }
}
