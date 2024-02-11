import 'package:flutter/material.dart';
import 'package:schedule_t/UI/IntroScreen/IntroPage.dart';
import 'package:schedule_t/UI/IntroScreen/MyStyles.dart';
import 'package:schedule_t/UI/ProgramStyle.dart';
import 'package:schedule_t/UI/LetsYouInPage/LetsYouInPage.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  
  List<Widget> _pages = [
    // Add more pages if necessary
    IntroPage(
      title: 'Schedule',
      description: 'Ми надаємо онлайн-заняття та попередньо записані лекції!',
      titleTopOffset: 40,
      fontForTitle: true, // Use Aubrey for the title
    ),
    IntroPage(
      title: 'Навчайтесь в будь-який час',
      description: '',
    ),
    IntroPage(
      title: 'Отримайте онлайн-сертифікат',
      description: 'Аналізуйте свої бали та відстежуйте результати',
    ),
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }
  Positioned _getSkipButton(double topPaddingForSkip, double screenWidth)
  {
    return 
      Positioned(
        top: topPaddingForSkip,
        right: 20,
        child: TextButton(
          onPressed: () {
            _pageController.animateToPage(
              _pages.length - 1,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          child: Text(
            'Skip',
            style: MyStyles.returnSkipButtonStyle(screenWidth / 336),
          ),
        ),
      );
  }
  void _passButton() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LetsYouInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;







    
    double screenWidth = MediaQuery.of(context).size.width;

    // Padding for 'Skip' button from the top of the screen
    double topPaddingForSkip = screenHeight * 0.1;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pages,
          ),
          _getSkipButton(topPaddingForSkip, screenWidth),
          // Place other overlay widgets if necessary
        ],
      ),
      bottomSheet: _currentPage != _pages.length - 1
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 20), // Placeholder for alignment
                  _buildPageIndicator(),
                  _getIconButton(), // Retrieve the custom icon button
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 20), // Placeholder for alignment
                  _buildPageIndicator(),
                  CustomButton(
                    text: 'Вхід', 
                    width: 200, 
                    height: 50, 
                    onPressedCallback: _passButton, // Правильний спосіб передачі функції
                  ), // Встановіть ширину згідно з вашими потребами
                ],
              ),
            ),
    );
  }

  Widget _getIconButton() {
    return IconButton(
      onPressed: () {
        if (_currentPage < _pages.length - 1) {
          _pageController.nextPage(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      },
      icon: Icon(
        Icons.arrow_forward_ios,
        color: Color(0xFF0961F5),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      children: List<Widget>.generate(_pages.length, (int index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 10,
          width: _currentPage == index ? 20 : 10, // Current page indicator is wider
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _currentPage == index ? Colors.blue : Colors.grey.withOpacity(0.5),
          ),
        );
      }),
    );
  }
}
