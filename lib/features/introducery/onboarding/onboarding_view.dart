// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_app/core/functions/navigate.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';
import 'package:se7ety_app/core/widgets/custom_btn.dart';
import 'package:se7ety_app/features/introducery/onboarding/onboarding_model.dart';
import 'package:se7ety_app/features/introducery/welcome.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  var pageController = PageController();
  int index = 0;
  int currentPage=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if(currentPage !=2)
          TextButton(
            onPressed: () {
              navigateWithReplacement(context, WelcomeView());
            },
            child: Text(
              "تخطي",
              style: getBodyStyle(color: AppColors.background),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: 3,
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                         pages[index].image,
                      height: 250),
                       Gap(30),
                      Text(
                        pages[index].title ,
                      style: getTitleStyle(),
                      textAlign: TextAlign.center,
                      ),
                      Gap(40),
                      // sub text
                      Text(
                        pages[index].description,
                          style: getBodyStyle(),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                      SizedBox(
                        height: 70,
                        child: Row(
                          children: [
                            SmoothPageIndicator(
                              controller: pageController,
                              count: 3,
                              effect: ExpandingDotsEffect(
                                activeDotColor: AppColors.background,
                                dotColor: AppColors.grey,
                                dotHeight: 10,
                                dotWidth: 13,
                              ),
                            ),
                            Spacer(),
                            if (index == 2)
                              CustomButton(
                                text: "هيا بنا ", 
                                onPressed: () {
                                  navigateWithReplacement(context, WelcomeView());
                                },
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
