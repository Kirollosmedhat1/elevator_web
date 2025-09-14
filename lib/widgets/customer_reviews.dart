import 'package:flutter/material.dart';

class ReviewData {
  final String review;
  final String reviewerName;
  final String source;

  ReviewData({
    required this.review,
    required this.reviewerName,
    required this.source,
  });
}

class CustomerReviews extends StatefulWidget {
  const CustomerReviews({super.key});

  @override
  State<CustomerReviews> createState() => _CustomerReviewsState();
}

class _CustomerReviewsState extends State<CustomerReviews> {
  int currentReviewIndex = 4; // Start at index 4 (5th review)

  final List<ReviewData> reviews = [
    ReviewData(
      review:
          "The truth is decent people in everything. Commitment to appointments on the day and continuous response to any inquiry and very polite and tasteful in addition to professionalism and excellent craftsmanship, excellence in prices and speed of implementation, the elevator was completed in three months despite external obstacles, God willing, we renew dealing with them in other projects soon... Greetings.",
      reviewerName: "Nasser Al-Sayed",
      source: "Facebook",
    ),
    ReviewData(
      review:
          "Excellent service and professional team. The installation was completed on time and the quality is outstanding. Highly recommend for anyone looking for reliable elevator solutions.",
      reviewerName: "Ahmed Hassan",
      source: "Google",
    ),
    ReviewData(
      review:
          "Outstanding customer service and technical expertise. The maintenance team is always responsive and thorough. Our building's elevators have never run better.",
      reviewerName: "Sarah Mohamed",
      source: "Facebook",
    ),
    ReviewData(
      review:
          "Professional installation and excellent after-sales service. The team was punctual, clean, and efficient. The elevators are working perfectly.",
      reviewerName: "Mohammed Al-Rashid",
      source: "Google",
    ),
    ReviewData(
      review:
          "First Saudi Elevator Company carried out our work in Al Rehab in our building about a year ago, one of more than 100 pipes in Al Rehab... Although my opinion is just one of hundreds of customers in Al Rehab praising their work and professionalism, I would like to thank them very much.",
      reviewerName: "Lydia Emil",
      source: "Google",
    ),
    ReviewData(
      review:
          "Great experience from consultation to installation. The team was knowledgeable and provided excellent recommendations. Very satisfied with the final result.",
      reviewerName: "Fatima Al-Zahra",
      source: "Facebook",
    ),
    ReviewData(
      review:
          "Reliable company with skilled technicians. They handled our modernization project professionally and completed it ahead of schedule. Highly recommended.",
      reviewerName: "Omar Abdullah",
      source: "Google",
    ),
    ReviewData(
      review:
          "Excellent workmanship and attention to detail. The elevators are running smoothly and the maintenance service is top-notch. Thank you for your professionalism.",
      reviewerName: "Aisha Khalid",
      source: "Facebook",
    ),
  ];

  void _previousReview() {
    setState(() {
      currentReviewIndex =
          (currentReviewIndex - 1 + reviews.length) % reviews.length;
    });
  }

  void _nextReview() {
    setState(() {
      currentReviewIndex = (currentReviewIndex + 1) % reviews.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Row(
        children: [
          // Left side - Shopping mall image
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/stairs.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
           Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.height * 1,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Customer reviews",
                    style: TextStyle(
                      fontSize: 28,
                      color: Color(0xFF1A232F),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),

                  // Review content with navigation arrows
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _previousReview,
                        icon: Icon(
                          Icons.chevron_left,
                          color: Color(0xFF1A232F),
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 20),

                      // Review text container
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '"${reviews[currentReviewIndex].review}"',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1A232F),
                                fontStyle: FontStyle.italic,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),

                            // Reviewer name and source
                            Text(
                              reviews[currentReviewIndex].reviewerName,
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF1A232F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              reviews[currentReviewIndex].source,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF89CFF0),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 20),
                      IconButton(
                        onPressed: _nextReview,
                        icon: Icon(
                          Icons.chevron_right,
                          color:Color(0xFF1A232F),
                          size: 32,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  // Pagination dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(reviews.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentReviewIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                index == currentReviewIndex
                                    ? Color(0xFF1A232F)
                                    : Color(0xFF89CFF0),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
