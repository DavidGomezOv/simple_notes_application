import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/auth/ui/screen/login_screen.dart';
import 'package:simple_notes_application/src/auth/ui/widgets/login_tab_bar_indicator_widget.dart';
import 'package:simple_notes_application/src/auth/ui/widgets/login_top_bar_widget.dart';
import 'package:simple_notes_application/src/auth/view_mode/auth_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:stacked/stacked.dart';

import 'register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
        viewModelBuilder: () => AuthViewModel(context),
        builder: (context, viewModel, child) {
          viewModel.setTabController(tabController);
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    color: HexColor.fromHex(CustomColors.colorBlack74),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const LoginTopBarWidget(),
                        const LoginTabBarIndicatorWidget(),
                        Expanded(
                          child: TabBarView(
                            controller: viewModel.tabController,
                            children: const [
                              LoginScreen(),
                              RegisterScreen(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30, right: 14),
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                              color: Colors.blue,
                              onPressed: viewModel.handleButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                viewModel.buttonLabel,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: viewModel.loading,
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      color: Colors.black.withAlpha(70),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
