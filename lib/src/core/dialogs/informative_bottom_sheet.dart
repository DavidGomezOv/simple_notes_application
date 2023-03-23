import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class InformativeBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const InformativeBottomSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Wrap(
        children: [
          Container(
            width: double.maxFinite,
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              padding: const EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: 6,
              ),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (request.title != null)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 5, bottom: 10, top: 4),
                          width: double.maxFinite,
                          child: Text(
                            request.title ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 5, bottom: 10),
                    child: Text(
                      request.description ?? '',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      maxLines: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: () =>
                            completer(SheetResponse(confirmed: false)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Text(
                            request.secondaryButtonTitle?.toUpperCase() ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () =>
                            completer(SheetResponse(confirmed: true)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            request.mainButtonTitle?.toUpperCase() ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
