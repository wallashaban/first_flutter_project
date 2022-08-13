// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:udemy_course/shared/components/components.dart';

class MassengerScreen extends StatelessWidget {
  const MassengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://thumbs.dreamstime.com/b/closeup-photo-funny-excited-lady-raise-fists-screaming-loudly-celebrating-money-lottery-winning-wealthy-rich-person-wear-casual-172563278.jpg'),
            ),
            const SizedBox(
              width: 10,
            ),
            titleText(text: 'Chats'),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 15,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 22,
                ),
              )),
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 15,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 22,
                ),
              )),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search),
                    Text('Search'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 90,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 8,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return buildStoryItem();
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return buildChatItem();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStoryItem() => Container(
        width: 80,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://thumbs.dreamstime.com/b/closeup-photo-funny-excited-lady-raise-fists-screaming-loudly-celebrating-money-lottery-winning-wealthy-rich-person-wear-casual-172563278.jpg'),
                ),
                CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.white,
                ),
                CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.blue,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            titleText(
              text: 'walaa shaaban',
              size: 12,
              maxLines: 2,
              overFlow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
  Widget buildChatItem() => 
  Row(
    children: [
      Stack(
        alignment: Alignment.bottomRight,
        children: const [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                'https://thumbs.dreamstime.com/b/closeup-photo-funny-excited-lady-raise-fists-screaming-loudly-celebrating-money-lottery-winning-wealthy-rich-person-wear-casual-172563278.jpg'),
          ),
          CircleAvatar(
            radius: 6,
            backgroundColor: Colors.white,
          ),
          CircleAvatar(
            radius: 6,
            backgroundColor: Colors.blue,
          )
        ],
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Walaa shaaban',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    'Hello, I hope Your are fine....!',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text('11:00 pm')
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
