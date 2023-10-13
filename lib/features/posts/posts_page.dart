import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:version_poc/common/api_client.dart';
import 'package:version_poc/common/base_tile.dart';
import 'package:version_poc/common/error_display.dart';
import 'package:version_poc/features/posts/post.dart';

final postsProvider = FutureProvider<List<Post>>(
  (ref) => ref.watch(apiClientProvider).getPosts(),
);

class PostsPage extends ConsumerWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postsProvider);
    return state.when(
      data: (posts) => ListView.separated(
        itemBuilder: (_, index) => _PostTile(posts[index]),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: posts.length,
      ),
      error: (_, __) => const Center(child: ErrorDisplay()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _PostTile extends StatelessWidget {
  final Post post;
  const _PostTile(
    this.post, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            post.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 6),
          Text(post.body),
        ],
      ),
    );
  }
}
