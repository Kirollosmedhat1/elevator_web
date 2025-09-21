import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF89CFF0),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.04,
      ),
      child: Column(
        children: [
          MediaQuery.of(context).size.width < 768
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mobile: Company info
                  _buildMobileCompanyInfo(context),
                  SizedBox(height: 30),
                  // Mobile: Links and Products in one row
                  Row(
                    children: [
                      Expanded(child: _buildMobileLinks(context)),
                      SizedBox(width: 20),
                      Expanded(child: _buildMobileProducts(context)),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Mobile: Branch locations
                  _buildMobileBranches(context),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column 1: Company Information
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo and Company Name
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF1A232F),
                                border: Border.all(
                                  color: Color(0xFF89CFF0),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "SFE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              "SAUDI FIRST ELEVATORS",
                              style: TextStyle(
                                color: Color(0xFF1A232F),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Company Description
                        Text(
                          "Saudi First Elevators in the field of supply, installation, maintenance and modernization of elevators and escalators of all kinds. Electric elevators include: Elevators that work with a two-speed system, elevators that work with a variable speed system (VVVF), hydraulic elevators. Food elevators (for villas and restaurants), service elevators in buildings. Cargo elevators. Patient elevators (bed elevator).",
                          style: TextStyle(
                            color: Color(0xFF1A232F),
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 30),

                        // Social Media Icons
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.play_circle_fill,
                                color: Color(0xFF1A232F),
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.business,
                                color: Color(0xFF1A232F),
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.facebook,
                                color: Color(0xFF1A232F),
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 40),

                  // Column 2: Important Links
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "IMPORTANT LINKS",
                          style: TextStyle(
                            color: Color(0xFF1A232F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),

                        _buildLink("Home", true),
                        _buildLink("About Company"),
                        _buildLink("Products and Solutions"),
                        _buildLink("Studio", false, true),
                        _buildLink("Articles"),
                        _buildLink("Careers"),
                        _buildLink("Contact us"),

                        SizedBox(height: 20),

                        // Language Selector
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Color(0xFF1A232F),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                child: Text(
                                  "🇬🇧",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "EN",
                              style: TextStyle(
                                color: Color(0xFF1A232F),
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFF1A232F),
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 40),

                  // Column 3: Products
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PRODUCTS",
                          style: TextStyle(
                            color: Color(0xFF1A232F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),

                        Text(
                          "مصاعد",
                          style: TextStyle(
                            color: Color(0xFF1A232F),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 40),

                  // Column 4: Branch Locations
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "HEADINGS",
                          style: TextStyle(
                            color: Color(0xFF1A232F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),

                        _buildBranchLocation(
                          "The main branch: Nasr City _ 50 Ali Amin Street (Mustafa El Nahas Extension)",
                        ),
                        SizedBox(height: 15),

                        _buildBranchLocation(
                          "October branch: Building 421 Omar Ibn Al-Khattab Street, 6th of October City First Floor",
                        ),
                        SizedBox(height: 15),

                        _buildBranchLocation(
                          "Mansoura Branch: Suez Canal Street next to Al Ajami Pharmacy in Badr Tower",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildLink(
    String text, [
    bool isHighlighted = false,
    bool hasDropdown = false,
  ]) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isHighlighted ? Color(0xFF1A232F) : Color(0xFF1A232F),
              fontSize: 14,
            ),
          ),
          if (hasDropdown)
            Icon(Icons.arrow_drop_down, color: Color(0xFF1A232F), size: 16),
        ],
      ),
    );
  }

  Widget _buildBranchLocation(String address) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_on, color: Color(0xFF1A232F), size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            address,
            style: TextStyle(
              color: Color(0xFF1A232F),
              fontSize: 12,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileCompanyInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1A232F),
                border: Border.all(color: Color(0xFF89CFF0), width: 2),
              ),
              child: Center(
                child: Text(
                  "SFE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "SAUDI FIRST ELEVATORS",
                style: TextStyle(
                  color: Color(0xFF1A232F),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Text(
          "Saudi First Elevators in the field of supply, installation, maintenance and modernization of elevators and escalators of all kinds.",
          style: TextStyle(color: Color(0xFF1A232F), fontSize: 11, height: 1.4),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_circle_fill,
                color: Color(0xFF1A232F),
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.business, color: Color(0xFF1A232F), size: 25),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.facebook, color: Color(0xFF1A232F), size: 25),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "LINKS",
          style: TextStyle(
            color: Color(0xFF1A232F),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        _buildLink("Home", true),
        _buildLink("About Company"),
        _buildLink("Products"),
        _buildLink("Articles"),
        _buildLink("Careers"),
        _buildLink("Contact us"),
      ],
    );
  }

  Widget _buildMobileProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PRODUCTS",
          style: TextStyle(
            color: Color(0xFF1A232F),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text("مصاعد", style: TextStyle(color: Color(0xFF1A232F), fontSize: 12)),
        SizedBox(height: 15),
        Row(
          children: [
            Container(
              width: 18,
              height: 12,
              decoration: BoxDecoration(
                color: Color(0xFF1A232F),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(child: Text("🇬🇧", style: TextStyle(fontSize: 8))),
            ),
            SizedBox(width: 6),
            Text(
              "EN",
              style: TextStyle(color: Color(0xFF1A232F), fontSize: 12),
            ),
            Icon(Icons.arrow_drop_down, color: Color(0xFF1A232F), size: 14),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileBranches(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "BRANCHES",
          style: TextStyle(
            color: Color(0xFF1A232F),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        _buildBranchLocation("Main: Nasr City, 50 Ali Amin Street"),
        SizedBox(height: 8),
        _buildBranchLocation("October: Building 421, 6th of October City"),
        SizedBox(height: 8),
        _buildBranchLocation("Mansoura: Suez Canal Street, Badr Tower"),
      ],
    );
  }
}
