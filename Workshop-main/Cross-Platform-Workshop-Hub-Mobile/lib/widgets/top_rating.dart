// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:workshop_mobi/model/workshop/ListWorkShopSortByRating.dart';
import 'package:workshop_mobi/widgets/course_preview_card.dart';

class TopRatingSection extends StatelessWidget {
  final Future<List<WorkshopRatingDTO>> workshopFuture;

  TopRatingSection({required this.workshopFuture});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Rating",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF674AEF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<WorkshopRatingDTO>>(
            future: workshopFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                return Column(
                  children: snapshot.data!
                      .map((workshop) => CoursePreviewCard(
                            courseid:workshop.id ,
                            teacherid:workshop.teacherId,
                            courseTitle: workshop.workshopName,
                            instructor: workshop.teacherName,
                            imageAsset: workshop
                                .workshopImageUrl, 
                            rating: workshop.rating,
                            price: workshop.price.toString(),
                            time:
                                '3h', 
                            authorName: workshop.teacherName,
                            avatarImageAsset: workshop
                                .teacherImage, 
                          ))
                      .toList(),
                );
              } else {
                return const Text("No data available");
              }
            },
          ),
        ],
      ),
    );
  }
}
