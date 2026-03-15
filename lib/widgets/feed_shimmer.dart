import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeedShimmer extends StatelessWidget {
  const FeedShimmer({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// PROFILE
                const ListTile(
                  leading: CircleAvatar(radius: 20, backgroundColor: Colors.white),
                  title: SizedBox(height: 10, width: 100),
                ),

                /// IMAGE
                Container(
                  height: 300,
                  color: Colors.white,
                ),

                const SizedBox(height: 10),

                /// ACTIONS
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.favorite_border),
                    SizedBox(width: 15),
                    Icon(Icons.chat_bubble_outline),
                    SizedBox(width: 15),
                    Icon(Icons.send),
                  ],
                ),

                const SizedBox(height: 10),

                /// TEXT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 10,
                    width: 200,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}