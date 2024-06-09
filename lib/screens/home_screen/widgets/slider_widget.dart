import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../product_screen/product_screen.dart';
import '../providers/slides_provider.dart';

class SliderWidget extends ConsumerStatefulWidget {
  const SliderWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends ConsumerState<SliderWidget> {
  late Timer _timer;

  int _currentPage = 0;
  int slideSize = 0;
  final PageController _pageController = PageController(initialPage: 0);

  startTimer() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
        if (_currentPage == slideSize - 1) {
          _currentPage = 0;
        } else {
          _currentPage++;
        }

        if (mounted && slideSize > 1) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ref.watch(slidesProvider).when(
          data: (data) {
            slideSize = data.length;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: constraints.maxWidth / 3,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: data.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => context.push(
                            "${ProductScreen.routeName}/${data[index].productId}"),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        data[index].imageUrl),
                                    fit: BoxFit.fitWidth),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Chip(
                                backgroundColor: const Color(0x7fffffff),
                                label: Text(
                                  '${index + 1}/${data.length}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_pageController.positions.isNotEmpty)
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: AnimatedSmoothIndicator(
                          onDotClicked: (index) {
                            // carouselController.animateToPage(index);
                          },
                          activeIndex: _pageController.page!.toInt(),
                          count: data.length,
                          effect: ExpandingDotsEffect(
                              dotHeight: 5,
                              dotWidth: 8,
                              dotColor: Colors.grey,
                              activeDotColor: context.theme.primaryColor),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
          error: (error, _) {
            debugPrint(error.toString());
            return const SizedBox.shrink();
          },
          loading: () => const SizedBox.shrink()),
    );
  }
}
