import 'package:flutter/material.dart';


class CalenderWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CalenderWidget();
  }
}


class _CalenderWidget extends State<CalenderWidget>{
  late DateTime _currentMonth;
  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _selectedDate = DateTime.now();
  }
  void _changeMonth(int change) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + change, 1);
    });
  }
  String _monthName(int month) {
    switch (month) {
      case 1: return 'January';
      case 2: return 'February';
      case 3: return 'March';
      case 4: return 'April';
      case 5: return 'May';
      case 6: return 'June';
      case 7: return 'July';
      case 8: return 'August';
      case 9: return 'September';
      case 10: return 'October';
      case 11: return 'November';
      case 12: return 'December';
      default: return '';
    }
  }

  int _getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
        return 29;
      }
      return 28;
    }
    const daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonth[month - 1];
  }

  int _getStartingDayOfWeek(int year, int month) {
    return DateTime(year, month, 1).weekday % 7;
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.19,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF07933E),
                    Color(0xFF007530),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: screenHeight * 0.08,
                    left: screenWidth * 0.08,
                    child: Text(
                      'Calender',
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight*0.9,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left, color: Colors.black),
                          onPressed: () => _changeMonth(-1),
                        ),
                        Text(
                          '${_monthName(_currentMonth.month)} ${_currentMonth.year}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF000000),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right, color: Colors.black),
                          onPressed: () => _changeMonth(1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Days of the week
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text('Sun', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('Mon', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('Tue', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('Wed', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('Thu', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('Fri', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('Sat', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Calendar Grid
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                        itemCount: _getDaysInMonth(_currentMonth.year, _currentMonth.month) + _getStartingDayOfWeek(_currentMonth.year, _currentMonth.month),
                        itemBuilder: (context, index) {
                          final startingDay = _getStartingDayOfWeek(_currentMonth.year, _currentMonth.month);
                          if (index < startingDay) {
                            return const SizedBox.shrink();
                          }

                          final day = index - startingDay + 1;
                          final isToday = day == DateTime.now().day &&
                              _currentMonth.month == DateTime.now().month &&
                              _currentMonth.year == DateTime.now().year;

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: isToday
                                  ? Border.all(color: const Color(0xFFCE232B), width: 2)
                                  : Border.all(color: Colors.transparent),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                day.toString(),
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: isToday ? const Color(0xFFCE232B) : const Color(0xFF000000),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

}