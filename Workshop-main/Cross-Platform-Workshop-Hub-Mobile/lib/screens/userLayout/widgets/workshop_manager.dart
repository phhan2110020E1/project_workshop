// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';
import 'package:workshop_mobi/screens/course_screen.dart';

class WorkshopListScreen extends StatefulWidget {
  final String token;
  const WorkshopListScreen({super.key, required this.token});

  @override
  _WorkshopListScreenState createState() => _WorkshopListScreenState();
}

class _WorkshopListScreenState extends State<WorkshopListScreen> {
  late Future<List<CourseResponses>> futureWorkshops;
  final ApiService apiService = ApiService();
  final TextEditingController searchController = TextEditingController();
  List<CourseResponses>? allWorkshops;
  List<CourseResponses>? filteredWorkshops;
  int selectedFilter = 2; // Default to 'All'
  List<bool> isSelected = [false, false, true]; // Corresponding to the filters

  @override
  void initState() {
    super.initState();
    futureWorkshops =
        apiService.listWorkShopDetailByStudent(widget.token).then((workshops) {
      allWorkshops = workshops;
      filteredWorkshops = workshops;
      return workshops;
    });
  }

  void filterWorkshops(String query) {
    List<CourseResponses> tempFiltered = [];
    if (selectedFilter != 2) {
      tempFiltered = allWorkshops?.where((workshop) {
            bool matchesStatus = (selectedFilter == 1 && !workshop.isPublic) ||
                (selectedFilter == 0 && workshop.isPublic);
            bool matchesQuery =
                workshop.name.toLowerCase().contains(query.toLowerCase());
            return matchesStatus && matchesQuery;
          }).toList() ??
          [];
    } else {
      tempFiltered = allWorkshops ?? [];
    }

    setState(() {
      filteredWorkshops = tempFiltered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Workshop Purchased',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 246, 246, 247),
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 4.0,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(122.0),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search Workshops',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(122.0)),
                    ),
                  ),
                  onChanged: filterWorkshops,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          MultiSelectContainer(
              maxSelectableCount: 1,
              prefix: MultiSelectPrefix(
                selectedPrefix: const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
              items: [
                MultiSelectCard(
                  value: 'All',
                  label: 'All',
                  decorations: MultiSelectItemDecorations(
                    decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    selectedDecoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                MultiSelectCard(
                  value: 'Is Coming',
                  label: 'Is Coming',
                  decorations: MultiSelectItemDecorations(
                    decoration: BoxDecoration(
                        color: Colors.lightBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    selectedDecoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                MultiSelectCard(
                  value: 'End',
                  label: 'End',
                  decorations: MultiSelectItemDecorations(
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
              onChange: (allSelectedItems, selectedItem) {
                setState(() {
                  selectedFilter = allSelectedItems.indexOf(selectedItem);
                  filterWorkshops(searchController.text);
                });
              }),
          Expanded(
            child: FutureBuilder<List<CourseResponses>>(
              future: futureWorkshops,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Workshop Purchased is Empty'));
                }

                return ListView(
                  children: filteredWorkshops!
                      .map((workshop) => Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CourseScreen(workshop),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                        workshop.courseMediaInfos[0].urlImage,
                                        fit: BoxFit.cover),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(workshop.name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Text('Leader: ${workshop.teacher}',
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.grey)),
                                    Row(
                                      children: [
                                        Icon(
                                            workshop.isPublic
                                                ? Icons.public
                                                : Icons.lock_outline,
                                            color: workshop.isPublic
                                                ? const Color.fromARGB(
                                                    255, 48, 173, 231)
                                                : const Color.fromARGB(
                                                    255, 241, 40, 14)),
                                        Text(
                                            workshop.isPublic
                                                ? 'Is Coming'
                                                : 'End ',
                                            style:
                                                const TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
