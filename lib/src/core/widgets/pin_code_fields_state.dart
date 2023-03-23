import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_notes_application/src/core/widgets/pin_code_fields_widgets.dart';

class PinCodeFieldsState extends State<PinCodeFields> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late List<String> _inputList;
  int _selectedIndex = 0;

  @override
  void initState() {
    _initializeFields();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: AbsorbPointer(
              absorbing: true,
              child: TextFormField(
                controller: _textEditingController,
                focusNode: _focusNode,
                enabled: widget.enabled,
                autofocus: widget.autofocus,
                autocorrect: false,
                keyboardType: widget.keyboardType,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.length),
                  ...widget.inputFormatters ?? [],
                ],
                enableInteractiveSelection: false,
                showCursor: false,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 0.6,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: _onFocus,
            child: Container(
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _generateFields(),
            ),
          ),
        ],
      ),
    );
  }

  void _initializeFields() {
    _initializeTextEditingController();
    _initializeFocusNode();
    _inputList = List<String>.filled(widget.length, "", growable: false);
    _initializeList();
  }

  void _initializeTextEditingController() {
    _textEditingController = widget.controller ?? TextEditingController();

    _textEditingController.addListener(() => _textEditingControllerListener());
  }

  void _textEditingControllerListener() {
    var currentText = _textEditingController.text;

    if (!widget.enabled || _inputList.join("") == currentText) return;

    if (currentText.length == widget.length) widget.onComplete(currentText);

    if (widget.autoHideKeyboard &&
        (currentText.isEmpty || currentText.length == widget.length)) {
      _focusNode.unfocus();
    }

    widget.onChange?.call(currentText);
    _updateTextField(currentText);
  }

  void _updateTextField(String text) async {
    var updatedList = List<String>.filled(widget.length, "");

    for (int i = 0; i < widget.length; i++) {
      updatedList[i] = text.length > i ? text[i] : "";
    }

    setState(() {
      _selectedIndex = text.length;
      _inputList = updatedList;
    });
  }

  void _initializeFocusNode() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  void _initializeList() {
    for (int i = 0; i < _inputList.length; i++) {
      _inputList[i] = "";
    }
  }

  void _onFocus() {
    if (_focusNode.hasFocus) _focusNode.unfocus();

    FocusScope.of(context).requestFocus(_focusNode);
  }

  Widget _generateFields() {
    var textFieldWidgets = <Widget>[];

    for (int i = 0; i < widget.length; i++) {
      Widget field = widget.responsive
          ? Flexible(
              child: _generateTextField(i),
            )
          : Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
              child: _generateTextField(i),
            );
      textFieldWidgets.add(field);
    }

    return widget.responsive
        ? Row(children: textFieldWidgets)
        : Wrap(children: textFieldWidgets);
  }

  Widget _generateTextField(int index) {
    return AnimatedContainer(
      duration: widget.animationDuration,
      margin: widget.margin,
      padding: widget.padding,
      curve: widget.animationCurve,
      width: widget.responsive ? null : widget.fieldWidth,
      height: widget.fieldHeight,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        border: Border(
          bottom: BorderSide(color: _getColor(index), width: 2),
        ), // _generateBorder(index),
      ),
      child: Center(
        child: AnimatedSwitcher(
          switchInCurve: widget.switchInAnimationCurve,
          switchOutCurve: widget.switchOutAnimationCurve,
          duration: widget.animationDuration,
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: child,
            );
          },
          child: Text(
            _getText(index),
            key: ValueKey(_inputList[index]),
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }

  Color _getColor(int index) {
    Color color = Colors.transparent;

    if (isIndexSelected(index)) {
      return color = widget.activeBorderColor;
    }

    color = widget.borderColor;

    return color;
  }

  bool isIndexSelected(int index) {
    if (!_focusNode.hasFocus || !widget.enabled) return false;

    return _selectedIndex == index ||
        (_selectedIndex == index + 1 && index + 1 == widget.length);
  }

  String _getText(int index) {
    if (widget.obscureText) {
      return _inputList[index]
          .replaceAll(RegExp(r'.'), widget.obscureCharacter);
    }

    return _inputList[index];
  }
}
