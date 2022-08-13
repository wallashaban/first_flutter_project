import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_course/modules/shop_app/shop_login/shop_login.dart';

import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/components/constants.dart';
import 'package:udemy_course/shared/network/local/shared_prefrences.dart';

class OboardingModel {
  final String image;
  final String body;
  final String title;
  OboardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  List<OboardingModel> model = [
    OboardingModel(
      body: 'Body Boarding 1',
      title: 'Title Boarding 1',
      image: 'assets/images/onboarding.jpeg',
    ),
    OboardingModel(
      body: 'Body Boarding 2',
      title: 'Title Boarding 2',
      image: 'assets/images/onboarding.jpeg',
    ),
    OboardingModel(
      body: 'Body Boarding 3',
      title: 'Title Boarding 3',
      image: 'assets/images/onboarding.jpeg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                CasheHelper.setBoolean(key: 'onBoarding', value: true)
                    .then((value) {
                      navigateAndeFinish(context: context, widget: ShopLoginScreen());
                    });
                
              },
              child: titleText(text: 'SKIP', color: defaultColor, size: 25)),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: PageView.builder(
                    controller: boardController,
                    itemCount: model.length,
                    onPageChanged: (index) {
                      if (index == model.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    itemBuilder: ((context, index) =>
                        buidPageViewItem(model: model[index])))),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                  onPressed: () {
                    if (isLast) {
                      CasheHelper.setBoolean(key: 'onBoarding', value: true)
                    .then((value) {
                      navigateAndeFinish(context: context, widget: ShopLoginScreen());
                    });
                    } else {
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buidPageViewItem({required OboardingModel model}) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          const SizedBox(
            height: 30,
          ),
          titleText(text: model.title, size: 24),
          const SizedBox(
            height: 15,
          ),
          titleText(text: model.body, size: 14),
        ],
      );
}
