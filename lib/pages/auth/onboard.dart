import 'package:app/widget/content_model.dart';
import 'package:flutter/material.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _controller;
  @override
  void dispose() {
    _controller = PageController(initialPage: 0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: content.length,
            onPageChanged: (int i) {
              setState(() {
                currentIndex = i;
              });
            },
            itemBuilder: (_, i) {
              return Container();
            },
          )
        ],
      ),
    );
  }
}
