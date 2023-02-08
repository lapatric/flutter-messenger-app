import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:messenger_app/helpers.dart';
import '../models/models.dart';
import '../theme.dart';
import '../widgets/widgets.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: _Stories(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(_delegate),
          )
        ],
      ),
    );
  }

  Widget _delegate(BuildContext context, int index) {
    final Faker faker = Faker();
    final date = Helpers.randomDate();
    return _MessageTile(
      messageData: MessageData(
          senderName: faker.person.name(),
          message: faker.lorem.sentence(),
          messageDate: date,
          dateMessage: Jiffy(date).fromNow(),
          profilePicture: Helpers.randomPictureUrl()),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({super.key, required this.messageData});

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.grey, width: 0.2),
      )),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Avatar.medium(url: messageData.profilePicture),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(messageData.senderName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            letterSpacing: 0.2,
                            wordSpacing: 1.5,
                            fontWeight: FontWeight.w900)),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      messageData.message,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textFaded),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    messageData.dateMessage.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textFaded,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
              child: Text(
                'Stories',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: AppColors.textFaded,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final faker =
                        Faker(); // faker allows us to grab fake data, e.g. fake people with names etc.
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 60,
                        child: _StoryCard(
                            storyData: StoryData(
                                name: faker.person.name(),
                                url: Helpers.randomPictureUrl())),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({super.key, required this.storyData});

  final StoryData
      storyData; // StoryData is our custom model, a bit like a struct

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          // expanded is used to avoid overflow error (potentially)
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow
                  .ellipsis, // three dots when not enough space for text
              style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
