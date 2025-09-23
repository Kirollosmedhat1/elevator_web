import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      review: 'review_1'.tr,
      reviewerName: 'reviewer_1'.tr,
      source: 'source_1'.tr,
    ),
    ReviewData(
      review: 'review_2'.tr,
      reviewerName: 'reviewer_2'.tr,
      source: 'source_2'.tr,
    ),
    ReviewData(
      review: 'review_3'.tr,
      reviewerName: 'reviewer_3'.tr,
      source: 'source_3'.tr,
    ),
    ReviewData(
      review: 'review_4'.tr,
      reviewerName: 'reviewer_4'.tr,
      source: 'source_4'.tr,
    ),
    ReviewData(
      review: 'review_5'.tr,
      reviewerName: 'reviewer_5'.tr,
      source: 'source_5'.tr,
    ),
    ReviewData(
      review: 'review_6'.tr,
      reviewerName: 'reviewer_6'.tr,
      source: 'source_6'.tr,
    ),
    ReviewData(
      review: 'review_7'.tr,
      reviewerName: 'reviewer_7'.tr,
      source: 'source_7'.tr,
    ),
    ReviewData(
      review: 'review_8'.tr,
      reviewerName: 'reviewer_8'.tr,
      source: 'source_8'.tr,
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
      height: MediaQuery.of(context).size.height * 0.75,
      child:
          MediaQuery.of(context).size.width < 1000
              ? Column(
                children: [
                  // Mobile: Image on top
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/customer_review.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Mobile: Reviews section below
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Title
                          Text(
                            'customer_reviews'.tr,
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF1A232F),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),

                          // Review content
                          Column(
                            children: [
                              Text(
                                '"${reviews[currentReviewIndex].review}"',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF1A232F),
                                  fontStyle: FontStyle.italic,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),

                              // Reviewer name and source
                              Text(
                                reviews[currentReviewIndex].reviewerName,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1A232F),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                reviews[currentReviewIndex].source,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF89CFF0),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 30),

                          // Navigation arrows and dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: _previousReview,
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: Color(0xFF1A232F),
                                  size: 28,
                                ),
                              ),
                              SizedBox(width: 20),
                              // Pagination dots
                              ...List.generate(reviews.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentReviewIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    width: 6,
                                    height: 6,
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
                              SizedBox(width: 20),
                              IconButton(
                                onPressed: _nextReview,
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Color(0xFF1A232F),
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
              : Row(
                children: [
                  // Left side - Shopping mall image
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/customer_review.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // Right side - Customer reviews section
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.height * 1,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Title
                          Text(
                            'customer_reviews'.tr,
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
                                  color: Color(0xFF1A232F),
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
                  ),
                ],
              ),
    );
  }
}
