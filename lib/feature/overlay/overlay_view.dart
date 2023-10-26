import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products_app/main/app_viewmodel.dart';
import 'package:products_app/main/navigation/route_paths.dart';
import 'package:products_app/providers/app_provider.dart';
import 'package:products_app/utils/font_size.dart';
import 'package:products_app/utils/helpers/shared_pref_helpers.dart';
import 'package:sizer/sizer.dart';

import '../../../base/base_page.dart';
import '../../generated/l10n.dart';
import '../../utils/color_utils.dart';
import 'overlay_model.dart';

class OverlayView extends BasePageViewWidget<OverlayViewModel> {
  OverlayView(ProviderBase providerBase) : super(providerBase);

  @override
  Widget build(BuildContext context, OverlayViewModel model) {
    model.delegate = S.of(context);

    return Consumer(
      builder: (context, ref, _) {
        List callLogsList = ref.watch(appNotifierProvider).callLogsList;

        return SafeArea(
          child: Container(
            color: AppColor.transparent,
            width: 100.w,
            height: 100.h,
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
                      appLevelKey.currentState?.pushNamedAndRemoveUntil(
                        RoutePaths.home,
                        (route) => false,
                      );
                    },
                    child: SizedBox(
                      width: 15.w,
                      height: 15.w,
                      child: const Icon(
                        Icons.close,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                ),

                // *** Call Logs List *** //
                Expanded(
                  child: ListView.builder(
                    itemCount: callLogsList.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      final caller = callLogsList[index];

                      // Generating Single Caller Item
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(caller["title"]),
                        subtitle: Text(caller["subTitle"]),
                        trailing: Icon(
                          caller["isIncomingCall"]
                              ? Icons.call
                              : Icons.call_missed,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
