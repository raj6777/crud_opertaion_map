import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DoctorOnBoardingPage extends StatefulWidget {
  const DoctorOnBoardingPage({super.key});

  @override
  State<DoctorOnBoardingPage> createState() => _DoctorOnboardingScreenState();
}

class _DoctorOnboardingScreenState extends State<DoctorOnBoardingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final List<String> dataList = List.generate(100, (index) => '${index + 1}');
  final double bottomReservedHeight = 320;
  final double itemHeight = 120.0;
  final double itemSpacing = 120.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 50), // Slower for better visibility
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    final availableHeight = fullHeight - bottomReservedHeight;
    final visibleItemCount = (availableHeight / itemSpacing).ceil() * 2;

    return Scaffold(
      body: Stack(
        children: [
        Positioned.fill(
        bottom: bottomReservedHeight,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final scrollOffset = _controller.value * itemSpacing * dataList.length;

            return Stack(
              children: dataList.map((value) {
                final index = dataList.indexOf(value);
                final isOdd = index % 2 == 1; // Check if odd-numbered

                // Calculate position based on scroll direction
                double position;
                if (isOdd) {
                  // Odd items (left side) scroll down
                  position = (index * itemSpacing - scrollOffset) % (itemSpacing * dataList.length);
                } else {
                  // Even items (right side) scroll up
                  position = (index * itemSpacing + scrollOffset) % (itemSpacing * dataList.length);
                }

                // Adjust for visible area
                if (position < -itemHeight) position += itemSpacing * dataList.length;
                if (position > availableHeight) position -= itemSpacing * dataList.length;

                // Skip if not visible
                if (position + itemHeight < 0 || position > availableHeight) {
                  return const SizedBox.shrink();
                }

                return Positioned(
                  top: position,
                  left: isOdd ? 20.0 : 180.0, // Left for odd, right for even
                  child: Container(
                    width: 120,
                    height: itemHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isOdd ? Colors.teal[300] : Colors.teal[100],
                    ),
                    child: Center(
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      // Bottom content remains the same
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                TextSpan(
                  text: "Expert Doctor ",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "Advice Online",
                        style: TextStyle(color: Colors.teal[700])),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                "Access professional medical guidance conveniently from the comfort of your home.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Skip", style: TextStyle(color: Colors.teal)),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      )],
      ),
    );
  }
}