import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final Widget? subtitle;
  final List<Widget> children;

  CustomExpansionTile({required this.title,  this.subtitle, required this.children});

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _iconRotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconRotation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Column(
        children: [
          Container(
           decoration: BoxDecoration(
             color: Colors.grey.shade500
           ),
            child: ListTile(
              onTap: _handleTap,
              title: widget.title,
              subtitle: widget.subtitle,
              trailing: RotationTransition(
                turns: _iconRotation,
                child: Icon(Icons.expand_more),
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: _controller,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 5.h),
                child: Column(children: widget.children)),
          ),
        ],
      ),
    );
  }
}