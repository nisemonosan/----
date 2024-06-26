import 'package:flutter/material.dart';

class MultiFloatingActionButton extends StatefulWidget {
  final List<FABItem> items;
  final Color? mainButtonColor;
  final Color? expandedButtonColor;

  MultiFloatingActionButton({
    Key? key,
    required this.items,
    this.mainButtonColor,
    this.expandedButtonColor,
  }) : super(key: key);

  @override
  _MultiFloatingActionButtonState createState() => _MultiFloatingActionButtonState();
}

class _MultiFloatingActionButtonState extends State<MultiFloatingActionButton> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeInOut; // イージングカーブを変更
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 300) // アニメーション時間を短縮
    )..addListener(() {
      setState(() {});
    });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: widget.mainButtonColor ?? Colors.blue,
      end: widget.expandedButtonColor ?? Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.00, 1.00, curve: Curves.linear),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.75, curve: _curve),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
          color: Colors.black,
        ),
        shape: CircleBorder(),
        elevation: 0, // 影を消す
      ),
    );
  }

  List<Widget> _buildExpandedButtons() {
    List<Widget> buttons = [];
    for (int i = 0; i < widget.items.length; i++) {
      buttons.add(
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * (widget.items.length - i),
            0.0,
          ),
          child: Container(
            child: FloatingActionButton(
              onPressed: () {
                widget.items[i].onPressed();
                animate();
              },
              tooltip: widget.items[i].tooltip,
              child: Icon(widget.items[i].icon, color: Colors.black),
              backgroundColor: widget.expandedButtonColor,
              shape: CircleBorder(),
              elevation: 0, // 影を消す
            ),
          ),
        ),
      );
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ..._buildExpandedButtons(),
        toggle(),
      ],
    );
  }
}

class FABItem {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  FABItem({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });
}