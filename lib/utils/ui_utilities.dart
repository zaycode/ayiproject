import 'package:ayi/config/app_color.dart';
import 'package:ayi/core/components/button.dart';
import 'package:ayi/domain/entity/base_entity.dart';
import 'package:ayi/utils/extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UIUtilities {
  UIUtilities._();

  static final _instance = UIUtilities._();

  factory UIUtilities() => _instance;

  static Future<ChoiceEntity?> bottomSheetLists(
      {required BuildContext context,
      required String title,
      required List<ChoiceEntity> listData,
      String? initialValue}) async {
    return showModalBottomSheet<ChoiceEntity?>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(8), topLeft: Radius.circular(8)),
      ),
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            minHeight: 320,
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight,
          ),
          padding: EdgeInsets.only(
              left: 16,
              top: 16,
              right: 16,
              bottom: 16 + MediaQuery.of(context).padding.bottom),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12, bottom: 16),
                    child: Text(
                      title.tr(),
                      style: context.textTheme.bodyText1?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  ListView.builder(
                      itemCount: listData.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final item = listData[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () =>
                                  Navigator.pop(context, listData[index]),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(
                                        item.title,
                                        style: context.textTheme.bodyText1
                                            ?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  item.code == initialValue
                                      ? Icon(
                                          Icons.check_circle,
                                          color: AppColors.primary,
                                          size: 24,
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey),
                          ],
                        );
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<List<ChoiceEntity>?> bottomSheetCheckBox(
      {required BuildContext context,
      required String title,
      required List<ChoiceEntity> listData,
      List<ChoiceEntity>? initialValue}) async {
    return showModalBottomSheet<List<ChoiceEntity>?>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(8), topLeft: Radius.circular(8)),
      ),
      builder: (BuildContext context) {

        List<ChoiceEntity> selected=[];
        initialValue?.forEach((element) {
          selected.add(element);
        });
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter myState) {
          return Container(
            constraints: BoxConstraints(
              minHeight: 320,
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight,
            ),
            padding: EdgeInsets.only(
              left: 16,
              top: 16,
              right: 16,
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 16),
                      child: Text(
                        title.tr(),
                        style: context.textTheme.bodyText1?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    ListView.builder(
                        itemCount: listData.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final item = listData[index];
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  myState(() {
                                    if (selected.contains(item)) {
                                      selected.remove(item);
                                    } else {
                                      selected.add(item);
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          item.title,
                                          style: context.textTheme.bodyText1
                                              ?.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    selected.contains(item)
                                        ? Icon(
                                            Icons.check_circle,
                                            color: AppColors.primary,
                                            size: 24,
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Divider(color: Colors.grey),
                            ],
                          );
                        }),
                    Button(
                        onTap: () {
                          Navigator.pop(context, selected);
                        },
                        margin: EdgeInsets.only(top: 24),
                        enable: selected.isNotNullOrEmpty(),
                        title: "btn_done".tr())
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
