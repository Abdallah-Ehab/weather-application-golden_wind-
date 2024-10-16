import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Background extends StatefulWidget {
  final Widget screen;
  final bool isNight;

  const Background({super.key, required this.screen, required this.isNight});

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  late Animation<double> _movementAnimation;
  late Animation<double> _moveAnimation2;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation1 = ColorTween(
      begin: widget.isNight ? Colors.black : Colors.blue[500],
      end: widget.isNight ? Colors.deepPurple[800] : Colors.blue[200],
    ).animate(_controller);

    _colorAnimation2 = ColorTween(
      begin: widget.isNight ? Colors.deepPurple : Colors.lightBlue[300],
      end: widget.isNight ? Colors.blueGrey : Colors.blue[200],
    ).animate(_controller);

    _movementAnimation = Tween(begin: -1.0, end: 1.0).animate(_controller);
    _moveAnimation2 = Tween(begin: -0.3, end: 0.3).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant Background oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.isNight != oldWidget.isNight) {
      _controller.dispose(); 
      _initializeAnimations();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 13, 63),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_colorAnimation1.value ?? Colors.black, _colorAnimation2.value ?? Colors.deepPurple],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(_movementAnimation.value, _movementAnimation.value),
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(_movementAnimation.value, _moveAnimation2.value),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  widget.screen,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
