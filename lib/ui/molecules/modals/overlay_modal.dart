import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products_app/di/app/app_modules.dart';
import 'package:products_app/feature/home/home_model.dart';
import 'package:products_app/main/app_viewmodel.dart';

import 'package:sizer/sizer.dart';

import '../../../utils/color_utils.dart';

Widget overlayModal({
  double? modelHeight,
  double? modelWidth,
}) {
  final _homeModelProvider =
      ProviderScope.containerOf(appLevelKey.currentState!.context)
          .read(homeModelProvider);

  return SafeArea(
    child: Material(
      type: MaterialType.transparency,
      child: Container(
        height: 100.h,
        width: 100.w,
        color: AppColor.black.withOpacity(0.48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // *** Close Icon *** //
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _homeModelProvider.isModalShown = false;
                  Navigator.pop(appLevelKey.currentState!.context);
                },
                child: SizedBox(
                  width: 15.w,
                  height: 15.w,
                  child: const Icon(
                    Icons.close,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),

            // *** Call Logs List *** //
            Consumer(builder: (context, ref, _) {
              final callLogsList = ref.watch(homeModelProvider).callLogsList;

              return Expanded(
                child: ListView.builder(
                  controller: _homeModelProvider.scrollController,
                  itemCount: callLogsList.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    final caller = callLogsList[index];

                    // Generating Single Caller Item
                    return ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: AppColor.green,
                      ),
                      title: Text(
                        caller["title"],
                        style: const TextStyle(
                          color: AppColor.white,
                        ),
                      ),
                      subtitle: Text(
                        caller["subTitle"],
                        style: const TextStyle(
                          color: AppColor.white,
                        ),
                      ),
                      trailing: Icon(
                        caller["isIncomingCall"]
                            ? Icons.call
                            : Icons.call_missed,
                        color: AppColor.green,
                      ),
                    );
                  }),
                ),
              );
            }),
          ],
        ),
      ),
    ),
  );
}
