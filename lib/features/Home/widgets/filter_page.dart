import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Tasks", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Search....")),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Result count (you can update it later dynamically)
            const Text("Results  4", style: TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            // Filter Container (represents UI from screenshot)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10)
                  ],
                ),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        FilterChip(
                            label: Text("All"),
                            selected: true,
                            onSelected: null),
                        FilterChip(
                            label: Text("Work"),
                            selected: false,
                            onSelected: null),
                        FilterChip(
                            label: Text("Home"),
                            selected: false,
                            onSelected: null),
                        FilterChip(
                            label: Text("Personal"),
                            selected: false,
                            onSelected: null),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        FilterChip(
                            label: Text("All"),
                            selected: true,
                            onSelected: null),
                        FilterChip(
                            label: Text("In Progress"),
                            selected: false,
                            onSelected: null),
                        FilterChip(
                            label: Text("Missed"),
                            selected: false,
                            onSelected: null),
                        FilterChip(
                            label: Text("Done"),
                            selected: false,
                            onSelected: null),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 10),
                        Text("30 June, 2022   10:00 pm"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: const Text("Filter",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
