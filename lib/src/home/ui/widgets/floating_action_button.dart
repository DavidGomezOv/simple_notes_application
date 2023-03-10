import 'package:flutter/material.dart';
import 'dart:math';

import 'package:simple_notes_application/src/home/view_model/home_view_model.dart';

class ExpandableFab extends StatefulWidget {
  final HomeViewModel viewModel;

  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.children,
    required this.viewModel,
  }) : super(key: key);

  final bool? initialOpen;
  final List<Widget> children;

  @override
  ExpandableFabState createState() => ExpandableFabState();
}

class ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool open = false;

  @override
  void initState() {
    super.initState();
    open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggle() {
    if (widget.viewModel.loading) return;
    setState(() {
      open = !open;
      if (open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        elevation: 4.0,
        child: InkWell(
          onTap: toggle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.close,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    double positionOffset = 80.0;
    for (var i = 0; i < count; i++) {
      children.add(
        _ExpandingActionButton(
          positionInScreenB: positionOffset,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
      positionOffset += 80.0;
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          open ? 0.7 : 1.0,
          open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: toggle,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.positionInScreenB,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double positionInScreenB;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        return Positioned(
          bottom: positionInScreenB,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
    required this.tag,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Icon icon;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: tag,
      onPressed: onPressed,
      child: icon,
    );
  }
}
