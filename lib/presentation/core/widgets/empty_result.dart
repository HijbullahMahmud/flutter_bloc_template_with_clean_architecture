import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/utility/asset_paths.dart';
import 'package:flutter_bloc_template/core/extensions/app_localization.dart';
import 'package:lottie/lottie.dart';

class EmptyResultView extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetryPressed;
  final TextStyle? messageTextStyle;
  const EmptyResultView({
    super.key,
    this.message,
    this.onRetryPressed,
    this.messageTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Lottie.asset(AssetPaths.empty, height: 150, width: 150),
          Text(
            message ?? '',
            textAlign: TextAlign.center,
            style: messageTextStyle ?? Theme.of(context).textTheme.bodyMedium,
          ),

          Visibility(
            visible: onRetryPressed != null,
            child: FilledButton(
              onPressed: onRetryPressed,
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: Text(context.locale.retry),
            ),
          ),
        ],
      ),
    );
  }
}
