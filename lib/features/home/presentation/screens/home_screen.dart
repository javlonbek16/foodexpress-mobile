import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FOOD EXPRESS MOBILE"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: .center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ColoredBox(color: Colors.red),
              ),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [Text("Kategoriyalar"), Icon(Icons.arrow_forward_ios_rounded)],
              ),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CircleAvatar(radius: 20),
                        const SizedBox(
                          width: 70,
                          child: Text(
                            "category",
                            textAlign: .center,
                            maxLines: 1,
                            overflow: .ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, _) {
                    return SizedBox(width: 10);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [Text("Mashhur taomlar"), Icon(Icons.arrow_forward_ios_rounded)],
              ),

              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber[100],
                      ),
                      width: 300,
                      child: Column(
                        children: [
                          Placeholder(fallbackHeight: 100),
                          Text("Name"),
                          Text("Description"),
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [Text("Price"), Text("Delivery time")],
                          ),
                          Row(
                            mainAxisAlignment: .spaceEvenly,
                            children: [
                              IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.remove)),
                              FilledButton(onPressed: () {}, child: Text("Qo'shish")),
                              IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.remove)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 10);
                  },
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
