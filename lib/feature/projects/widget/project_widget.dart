import 'package:flutter/material.dart';


class ProjectsWidget extends StatelessWidget {
  const ProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final List<Map<String, dynamic>> projects = [
      {
        'title': 'Intercom',
        'subtitle': 'Digital Product Design',
        'progress': 0.88,
        'dueDate': 'July 23, 2022',
        'teamSize': 3,
        'borderColor': const Color(0xFF07933E),
      },
      {
        'title': 'Zoho Recruit',
        'subtitle': 'Dashboard UI',
        'progress': 0.58,
        'dueDate': 'June 12, 2022',
        'teamSize': 3,
        'borderColor': const Color(0xFFCE232B),
      },
      {
        'title': 'Healthy Sure',
        'subtitle': 'Landing Page Website',
        'progress': 0.30,
        'dueDate': 'June 6, 2022',
        'teamSize': 5,
        'borderColor': const Color(0xFF07933E),
      },
      {
        'title': 'UI/UX Studio',
        'subtitle': 'Landing Page Website',
        'progress': 0.54,
        'dueDate': 'June 6, 2022',
        'teamSize': 3,
        'borderColor': const Color(0xFFCE232B),
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header with Green Gradient
            Container(
              height: screenHeight * 0.25,
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
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08, vertical: screenHeight * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Projects',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.search,
                          color: Colors.white, size: screenWidth * 0.06),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            // Project Cards List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              itemBuilder: (context, index) {
                final project = projects[index];
                return _buildProjectCard(
                  context,
                  title: project['title'],
                  subtitle: project['subtitle'],
                  progress: project['progress'],
                  dueDate: project['dueDate'],
                  teamSize: project['teamSize'],
                  borderColor: project['borderColor'],
                );
              },
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context,
      {required String title,
        required String subtitle,
        required double progress,
        required String dueDate,
        required int teamSize,
        required Color borderColor}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.015,
            height: screenHeight * 0.1,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF000000),
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Team',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Row(
                          children: [
                            _buildAvatar(),
                            _buildAvatar(),
                            _buildAvatar(),
                            _buildAvatar(isMore: true, count: teamSize),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Due date',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          dueDate,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                      (progress > 0.5) ? const Color(0xFF07933E) : const Color(0xFFCE232B)),
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF000000),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar({bool isMore = false, int count = 0}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isMore ? Colors.grey[400] : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: isMore
          ? Center(
        child: Text(
          '+$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : null, // For simplicity, we're not using a real image.
    );
  }
}
