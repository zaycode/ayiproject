import 'dart:io';

import 'package:ayi/utils/extension.dart';
import 'package:ayi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditText extends FormField<String> {
  final String? label;
  final String? hint;
  final bool obscureText;
  final Widget? suffix;
  final Widget? outerSuffix;
  final bool readOnly;
  final Widget? prefix;
  final bool autoFocus;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final int? lines;
  final VoidCallback? onTap;
  final Color? color;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? textInputFormatters;
  final FieldType type;
  final ActionType? textActionType;

//<<<<<<< Updated upstream
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final TextEditingController? controller;
  final EdgeInsets? margin;
  final String? suffixText;
  final Color? bgColor;
  final Color? labelColor;
  final bool isRequired;
  final bool isHideBorder;
  final EdgeInsets? paddingError;
  final EdgeInsets? scrollPadding;

  EditText({
    Key? key,
    this.controller,
    this.label,
    this.type = FieldType.text,
    this.hint,
    this.obscureText = false,
    this.suffix,
    this.readOnly = false,
    this.bgColor,
    this.outerSuffix,
    this.prefix,
    this.minLines,
    this.maxLength,
    this.color = Colors.transparent,
    this.maxLines,
    this.lines,
    this.onTap,
    this.autoFocus = false,
    this.textInputFormatters,
    this.validator,
    this.onSubmit,
    this.textActionType,
    this.focusNode,
    this.onChanged,
    this.margin,
    this.suffixText,
    this.labelColor,
    this.isHideBorder = false,
    this.isRequired = false,
    this.paddingError,
    this.scrollPadding,
    TextStyle? hintStyle,
    TextStyle? textStyle,
    bool optional = false,
  }) : super(
          key: key,
          validator: validator,
          enabled: true,
          autovalidateMode: AutovalidateMode.disabled,
          initialValue: controller != null ? controller.text : "",
          builder: (FormFieldState<String> field) {
            final _EditTextState state = field as _EditTextState;
            hintStyle = hintStyle ??
                TextStyle(
                    color: Color(0xffa8a8a8),
                    fontSize: 16,
                    fontWeight: FontWeight.w400);

            textStyle = textStyle ??
                TextStyle(
                  color: Color(0xff3a3a3c),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                );
            var inputFormatters = textInputFormatters ?? [];
            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            TextInputType getTextInputType() {
              switch (type) {
                case FieldType.email:
                  return TextInputType.emailAddress;
                case FieldType.phone:
                  return TextInputType.phone;
                case FieldType.multiline:
                  return TextInputType.multiline;
                case FieldType.number:
                  if (Platform.isIOS) {
                    inputFormatters.addAll([
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,4}'))
                    ]);
                    return TextInputType.numberWithOptions(
                        signed: true, decimal: true);
                  }
                  return TextInputType.number;

                case FieldType.text:
                  return TextInputType.text;
                default:
                  inputFormatters.add(FilteringTextInputFormatter.allow(
                      RegExp(Utils.regularRegex)));
                  return TextInputType.text;
              }
            }

            TextInputAction getActionInputType() {
              switch (textActionType) {
                case ActionType.next:
                  return TextInputAction.next;
                case ActionType.done:
                  return TextInputAction.done;
                default:
                  return TextInputAction.next;
              }
            }

            return Container(
              margin: margin ?? EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!label.isNullOrEmpty)
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        label ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      if (onTap != null) {
                        FocusScope.of(field.context).unfocus();
                        onTap();
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                              right: 16,
                              left: 16,
                            ),
                            decoration: BoxDecoration(
                              color: bgColor != null
                                  ? bgColor
                                  : readOnly
                                      ? Color(0xFF969899).withOpacity(0.08)
                                      : color,
                              border: isHideBorder == false
                                  ? Border.all(
                                      color: field.errorText != null
                                          ? Colors.red
                                          : Color(0xFFD5D5D5),
                                      width: 1,
                                    )
                                  : null,
                              borderRadius: outerSuffix == null
                                  ? BorderRadius.circular(8)
                                  : const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                            ),
                            child: Row(
                              children: [
                                prefix ?? Container(),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: IgnorePointer(
                                    ignoring: onTap != null,
                                    child: TextField(
                                      scrollPadding:
                                          scrollPadding ?? EdgeInsets.all(20.0),
                                      maxLength: maxLength,
                                      textInputAction: getActionInputType(),
                                      keyboardType: getTextInputType(),
                                      autofocus: autoFocus,
                                      focusNode: focusNode,
                                      onSubmitted: onSubmit,
                                      inputFormatters: inputFormatters,
                                      controller: state._effectiveController,
                                      readOnly: readOnly,
                                      onChanged: onChangedHandler,
                                      obscureText: obscureText,
                                      minLines: lines ?? minLines ?? 1,
                                      maxLines: lines ?? maxLines ?? 1,
                                      style: textStyle,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 14),
                                        suffixText: suffixText,
                                        hintText: hint,
                                        counterText: "",
                                        hintStyle: hintStyle,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                suffix ?? Container()
                              ],
                            ),
                          ),
                        ),
                        outerSuffix ?? Container(),
                      ],
                    ),
                  ),
                  if (field.errorText != null)
                    Container(
                      padding: paddingError,
                      margin: const EdgeInsets.only(top: 6),
                      child: Text(
                        field.errorText ?? "",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    )
                ],
              ),
            );
          },
        );

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends FormFieldState<String> {
  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!;

  @override
  EditText get widget => super.widget as EditText;

  TextInputType getTextInputType() {
    switch (widget.type) {
      case FieldType.email:
        return TextInputType.emailAddress;
      case FieldType.phone:
        return TextInputType.phone;
      case FieldType.multiline:
        return TextInputType.multiline;
      case FieldType.number:
        return TextInputType.number;

      default:
        return TextInputType.text;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller?.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(EditText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller =
            TextEditingController.fromValue(oldWidget.controller?.value);
      }
      if (widget.controller != null) {
        setValue(widget.controller?.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}

enum FieldType {
  text,
  name,
  email,
  phone,
  password,
  number,
  multiline,
}

enum ActionType { next, done }

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;
  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
