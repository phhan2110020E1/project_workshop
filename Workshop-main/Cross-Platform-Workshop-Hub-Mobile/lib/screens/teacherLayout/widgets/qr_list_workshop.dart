import 'package:flutter/material.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/qr_scan.dart';

class QrListWorkShop extends StatefulWidget {
  final String token;
  const QrListWorkShop({super.key, required this.token});

  @override
  State<QrListWorkShop> createState() => _QrListWorkShopState();
}

class _QrListWorkShopState extends State<QrListWorkShop> {
  late Future<List<CourseResponses>> futureWorkshops;
  final ApiService apiService = ApiService();
  final TextEditingController searchController = TextEditingController();
  List<CourseResponses>? allWorkshops;
  List<CourseResponses>? filteredWorkshops;
  @override
  void initState() {
    super.initState();
    futureWorkshops =
        apiService.listWorkShopTeacher(widget.token).then((workshops) {
      allWorkshops = workshops;
      filteredWorkshops = workshops;
      return workshops;
    });
  }

  void filterWorkshops(String query) {
    List<CourseResponses> tempFiltered = allWorkshops?.where((workshop) {
          return workshop.name.toLowerCase().contains(query.toLowerCase());
        }).toList() ??
        [];

    setState(() {
      filteredWorkshops = tempFiltered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workshop Scan'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Workshops',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: filterWorkshops,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CourseResponses>>(
              future: futureWorkshops,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Workshops Found'));
                }
                return ListView.builder(
                  itemCount: filteredWorkshops!.length,
                  itemBuilder: (context, index) {
                    var workshop = filteredWorkshops![index];
                    if (workshop.isPublic == true) {
                      return ListTile(
                        leading: Image.network(
                            workshop.courseMediaInfos[0].urlImage,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover),
                        title: Text(workshop.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.qr_code),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QrScan(
                                        workshopId: workshop.id,
                                        token: widget.token,
                                      )),
                            );
                          },
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
