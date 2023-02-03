import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:stacked_services/stacked_services.dart';

class AlertBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const AlertBottomSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: double.maxFinite,
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          padding: const EdgeInsets.all(10),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (request.title != null)
                Container(
                  padding: const EdgeInsets.only(left: 5, bottom: 10, top: 4),
                  width: double.maxFinite,
                  child: Text(
                    request.title ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 5, bottom: 10),
                child: Text(
                  request.description ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 15,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4, bottom: 2),
                  child: GestureDetector(
                    onTap: () => completer(SheetResponse(confirmed: true)),
                    child: Text(
                      request.mainButtonTitle?.toUpperCase() ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor.fromHex(CustomColors.colorPurple),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
