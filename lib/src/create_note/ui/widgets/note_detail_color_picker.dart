import 'package:flutter/material.dart';

class CustomColorPicker extends StatefulWidget {
  final Function(Color color) onSelectColor;
  final List<Color> availableColors;
  final Color initialColor;
  final bool circleItem;
  final Color backgroundColor;

  const CustomColorPicker(
      {Key? key,
      required this.onSelectColor,
      required this.availableColors,
      required this.initialColor,
      this.circleItem = true,
      required this.backgroundColor})
      : super(key: key);

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  late Color _pickedColor;
  late Color backgroundColor;

  @override
  void initState() {
    _pickedColor = widget.initialColor;
    backgroundColor = widget.backgroundColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: backgroundColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.availableColors.length,
        itemBuilder: (context, index) {
          final Color itemColor = widget.availableColors[index];
          return InkWell(
            onTap: () {
              widget.onSelectColor(itemColor);
              setState(() {
                _pickedColor = itemColor;
                backgroundColor = _pickedColor;
              });
            },
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: itemColor,
                  shape: widget.circleItem == true
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  border: Border.all(width: 1, color: Colors.grey[300]!)),
              child: itemColor == _pickedColor
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
            ),
          );
        },
      ),
    );
  }
}
