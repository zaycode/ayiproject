library flutter_datetime_picker;

import 'dart:async';

import 'package:ayi/config/app_color.dart';
import 'package:ayi/core/components/button.dart';
import 'package:ayi/core/library/datetime_picker/src/date_model.dart';
import 'package:ayi/core/library/datetime_picker/src/datetime_picker_theme.dart';
import 'package:ayi/utils/extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'src/i18n_model.dart';

typedef DateChangedCallback(DateTime time);
typedef DateCancelledCallback();
typedef String? StringAtIndexCallBack(int index);

class DateTimePicker {
  ///
  /// Display date picker bottom sheet.
  ///
  static Future<DateTime?> showDatePicker(
    BuildContext context, {
    String title: "",
    String type: "date",
    bool showTitleActions: true,
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale: LocaleType.en,
    DateTime? currentTime,
    DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        title: title,
        type: type,
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: DatePickerModel(
          currentTime: currentTime,
          maxTime: maxTime,
          minTime: minTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display Month picker bottom sheet.
  ///
  static Future<DateTime?> showMonthPicker(
    BuildContext context, {
    String title: "",
    String type: "month",
    bool showTitleActions: true,
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale: LocaleType.en,
    DateTime? currentTime,
    DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        title: title,
        type: type,
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: MonthPickerModel(
          currentTime: currentTime,
          maxTime: maxTime,
          minTime: minTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display time picker bottom sheet.
  ///
  static Future<DateTime?> showTimePicker(
    BuildContext context, {
    String title: "",
    String type: "time",
    bool showTitleActions: true,
    bool showSecondsColumn: true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale: LocaleType.en,
    DateTime? currentTime,
    DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        title: title,
        type: type,
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: TimePickerModel(
          currentTime: currentTime,
          locale: locale,
          showSecondsColumn: showSecondsColumn,
        ),
      ),
    );
  }

  ///
  /// Display time picker bottom sheet with AM/PM.
  ///
  static Future<DateTime?> showTime12hPicker(
    BuildContext context, {
    String title: "",
    String type: "time",
    bool showTitleActions: true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale: LocaleType.en,
    DateTime? currentTime,
    DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        title: title,
        type: type,
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: Time12hPickerModel(
          currentTime: currentTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display date&time picker bottom sheet.
  ///
  static Future<DateTime?> showDateTimePicker(
    BuildContext context, {
    required String title,
    String type: "time",
    bool showTitleActions: true,
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale: LocaleType.en,
    DateTime? currentTime,
    DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        title: title,
        type: type,
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: DateTimePickerModel(
          currentTime: currentTime,
          minTime: minTime,
          maxTime: maxTime,
          locale: locale,
        ),
      ),
    );
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    required this.title,
    required this.type,
    this.showTitleActions,
    this.onChanged,
    this.onConfirm,
    this.onCancel,
    DatePickerTheme? theme,
    this.barrierLabel,
    this.locale,
    RouteSettings? settings,
    BasePickerModel? pickerModel,
  })  : this.pickerModel = pickerModel ?? DatePickerModel(),
        this.theme = theme ?? DatePickerTheme(),
        super(settings: settings);

  final String title;
  final String type;
  final bool? showTitleActions;
  final DateChangedCallback? onChanged;
  final DateChangedCallback? onConfirm;
  final DateCancelledCallback? onCancel;
  final LocaleType? locale;
  final DatePickerTheme theme;
  final BasePickerModel pickerModel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _DatePickerComponent(
        title: title,
        type: type,
        onChanged: onChanged,
        locale: this.locale,
        route: this,
        pickerModel: pickerModel,
      ),
    );
    return InheritedTheme.captureAll(context, bottomSheet);
  }
}

class _DatePickerComponent extends StatefulWidget {
  _DatePickerComponent({
    Key? key,
    required this.title,
    required this.type,
    required this.route,
    required this.pickerModel,
    this.onChanged,
    this.locale,
  }) : super(key: key);

  final String title;
  final String type;
  final DateChangedCallback? onChanged;

  final _DatePickerRoute route;

  final LocaleType? locale;

  final BasePickerModel pickerModel;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<_DatePickerComponent> {
  late FixedExtentScrollController leftScrollCtrl,
      middleScrollCtrl,
      rightScrollCtrl;

  @override
  void initState() {
    super.initState();
    refreshScrollOffset();
  }

  void refreshScrollOffset() {
//    debugPrint('refreshScrollOffset ${widget.pickerModel.currentRightIndex()}');
    leftScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex());
    middleScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentMiddleIndex());
    rightScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex());
  }

  @override
  Widget build(BuildContext context) {
    DatePickerTheme theme = widget.route.theme;
    return GestureDetector(
      child: AnimatedBuilder(
        animation: widget.route.animation!,
        builder: (BuildContext context, Widget? child) {
          final double bottomPadding = MediaQuery.of(context).padding.bottom;
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _BottomPickerLayout(
                widget.route.animation!.value,
                widget.type,
                theme,
                showTitleActions: widget.route.showTitleActions!,
                bottomPadding: bottomPadding,
              ),
              child: GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  child: Material(
                    color: theme.backgroundColor,
                    child: _renderPickerView(theme, widget.title, widget.type),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(widget.pickerModel.finalTime()!);
    }
  }

  Widget _renderPickerView(DatePickerTheme theme, String title, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _renderTitleActionsView(theme, title),
        _renderSubTitleView(theme, title, type),
        _renderItemView(theme, type),
        Button(
            title: "btn_done".tr(),
            margin: EdgeInsets.fromLTRB(16, 24, 16, 8),
            onTap: () {
              Navigator.pop(context, widget.pickerModel.finalTime());
              if (widget.route.onConfirm != null) {
                widget.route.onConfirm!(widget.pickerModel.finalTime()!);
              }
            })
      ],
    );
  }

  Widget _renderColumnView(
    ValueKey key,
    DatePickerTheme theme,
    StringAtIndexCallBack stringAtIndexCB,
    ScrollController scrollController,
    int layoutProportion,
    ValueChanged<int> selectedChangedWhenScrolling,
    ValueChanged<int> selectedChangedWhenScrollEnd,
  ) {
    return Expanded(
      flex: layoutProportion,
      child: Container(
        height: theme.containerHeightV2,
        child: Stack(
          children: [
            Container(
              height: theme.containerHeightV2,
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if (notification.depth == 0 &&
                      notification is ScrollEndNotification &&
                      notification.metrics is FixedExtentMetrics) {
                    final FixedExtentMetrics metrics =
                        notification.metrics as FixedExtentMetrics;
                    final int currentItemIndex = metrics.itemIndex;
                    selectedChangedWhenScrollEnd(currentItemIndex);
                  }
                  return false;
                },
                child: CupertinoPicker.builder(
                  key: key,
                  scrollController:
                      scrollController as FixedExtentScrollController,
                  itemExtent: 50,
                  backgroundColor: Colors.transparent,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: Colors.transparent,
                  ),
                  onSelectedItemChanged: (int index) {
                    selectedChangedWhenScrolling(index);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final content = stringAtIndexCB(index);
                    if (content == null) {
                      return null;
                    }
                    return Container(
                      height: theme.itemHeight,
                      alignment: Alignment.center,
                      child: Text(
                        content,
                        style: context.textTheme.bodyText2?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: theme.containerHeightV2,
              child: Column(
                children: [
                  Container(height: 40),
                  Divider(color: Colors.grey),
                  Container(height: 25),
                  Divider(color: Colors.grey),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _renderItemView(DatePickerTheme theme, String type) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: widget.pickerModel.layoutProportions()[0] > 0
                ? _renderColumnView(
                    ValueKey(widget.pickerModel.currentLeftIndex()),
                    theme,
                    widget.pickerModel.leftStringAtIndex,
                    leftScrollCtrl,
                    widget.pickerModel.layoutProportions()[0], (index) {
                    widget.pickerModel.setLeftIndex(index);
                  }, (index) {
                    setState(() {
                      refreshScrollOffset();
                      _notifyDateChanged();
                    });
                  })
                : null,
          ),
          Container(
            child: widget.pickerModel.layoutProportions()[1] > 0
                ? _renderColumnView(
                    ValueKey(widget.pickerModel.currentLeftIndex()),
                    theme,
                    widget.pickerModel.middleStringAtIndex,
                    middleScrollCtrl,
                    widget.pickerModel.layoutProportions()[1], (index) {
                    widget.pickerModel.setMiddleIndex(index);
                  }, (index) {
                    setState(() {
                      refreshScrollOffset();
                      _notifyDateChanged();
                    });
                  })
                : null,
          ),
          (type == "month")
              ? Container()
              : Container(
                  child: widget.pickerModel.layoutProportions()[2] > 0
                      ? _renderColumnView(
                          ValueKey(
                              widget.pickerModel.currentMiddleIndex() * 100 +
                                  widget.pickerModel.currentLeftIndex()),
                          theme,
                          widget.pickerModel.rightStringAtIndex,
                          rightScrollCtrl,
                          widget.pickerModel.layoutProportions()[2], (index) {
                          widget.pickerModel.setRightIndex(index);
                        }, (index) {
                          setState(() {
                            refreshScrollOffset();
                            _notifyDateChanged();
                          });
                        })
                      : null,
                ),
        ],
      ),
    );
  }

  // Title View
  Widget _renderTitleActionsView(DatePickerTheme theme, String title) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: theme.headerColor ?? theme.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                if (widget.route.onCancel != null) {
                  widget.route.onCancel!();
                }
              },
              child: Icon(
                Icons.close,
                color: AppColors.primary,
                size: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              title.tr(),
              style: context.textTheme.bodyText1?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  // Sub Title View
  Widget _renderSubTitleView(DatePickerTheme theme, String title, String type) {
    // debugPrint('Translation');
    // debugPrint('Day : ${context.localization.translate("day")}');
    // debugPrint('Month : ${context.localization.translate("month")}');
    // debugPrint('Year : ${context.localization.translate("year")}');

    return (type == "date")
        ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "day".tr(),
                      style: context.textTheme.bodyText1?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                Container(width: 32),
                Expanded(
                  child: Center(
                    child: Text(
                      "month".tr(),
                      style: context.textTheme.bodyText1?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                Container(width: 32),
                Expanded(
                  child: Center(
                    child: Text(
                      "year".tr(),
                      style: context.textTheme.bodyText1?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          )
        : (type == "month")
            ? Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "month".tr(),
                          style: context.textTheme.bodyText1?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Container(width: 32),
                    Expanded(
                      child: Center(
                        child: Text(
                          "year".tr(),
                          style: context.textTheme.bodyText1?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container();
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(
    this.progress,
    this.type,
    this.theme, {
    this.itemCount,
    this.showTitleActions,
    this.bottomPadding = 0,
  });

  final double progress;
  final String type;
  final int? itemCount;
  final bool? showTitleActions;
  final DatePickerTheme theme;
  final double bottomPadding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeightV2;
    if (showTitleActions == true) {
      maxHeight += theme.titleHeight;
    }
    int plus = (type == "date" || type == "month") ? 145 : 100;
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: maxHeight + bottomPadding + plus,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final height = size.height - childSize.height * progress;
    return Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
