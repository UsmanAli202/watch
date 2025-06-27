import 'package:flutter/material.dart';
import 'dart:async';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late Timer _timer;
  late DateTime _currentTime;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Responsive font sizes based on screen size
    final timeFontSize = screenWidth * 0.15; // 15% of screen width
    final dateFontSize = screenWidth * 0.04; // 4% of screen width
    final secondsFontSize = screenWidth * 0.025; // 2.5% of screen width

    // Theme colors
    final backgroundColor = _isDarkMode ? Colors.black : Colors.white;
    final textColor = _isDarkMode ? Colors.white : Colors.black;
    final accentColor = _isDarkMode ? Colors.blue : Colors.blue.shade800;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Main clock content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Time display
                Text(
                  '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: timeFontSize,
                    fontWeight: FontWeight.w300,
                    color: textColor,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 20),

                // Seconds display
                Text(
                  _currentTime.second.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: secondsFontSize,
                    fontWeight: FontWeight.w200,
                    color: textColor.withOpacity(0.7),
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 40),

                // Date display
                Text(
                  '${_getDayName(_currentTime.weekday)}, ${_getMonthName(_currentTime.month)} ${_currentTime.day}, ${_currentTime.year}',
                  style: TextStyle(
                    fontSize: dateFontSize,
                    fontWeight: FontWeight.w400,
                    color: textColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // Dark mode toggle button (top-left)
          Positioned(
            top: mediaQuery.padding.top + 20,
            left: 20,
            child: GestureDetector(
              onTap: _toggleDarkMode,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accentColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: accentColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday];
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }
}
