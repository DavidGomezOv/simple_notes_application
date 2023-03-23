import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class ErrorBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const ErrorBottomSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Wrap(
        children: [
          Container(
            width: double.maxFinite,
            alignment: Alignment.bottomCenter,
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
                      padding:
                          const EdgeInsets.only(left: 5, bottom: 10, top: 4),
                      width: double.maxFinite,
                      child: Text(
                        request.title ?? '',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 5, bottom: 10),
                    child: Text(
                      request.description ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
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
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
