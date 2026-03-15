import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../data/models/comment_model.dart';
import '../../../data/models/post_model.dart';
import '../../../providers/comment_provider.dart';

class CommentView extends StatefulWidget {
  final Post post;

  const CommentView({super.key, required this.post});

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final _commentController = TextEditingController();

  void _submitComment() {
    if (_commentController.text.isNotEmpty) {
      context.read<CommentProvider>().addComment(
            widget.post.id,
            _commentController.text,
            "demo_user", // Current logged-in user
            "https://i.pravatar.cc/150?img=50",
          );
      _commentController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text("Comments", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Post Caption Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(widget.post.profileImage),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(text: "${widget.post.username} ", style: const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: widget.post.caption),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          // Comments List
          Expanded(
            child: Consumer<CommentProvider>(
              builder: (context, provider, child) {
                final comments = provider.getCommentsForPost(widget.post.id);
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return _CommentTile(comment: comment);
                  },
                );
              },
            ),
          ),
          // Comment Input
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
        top: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=50"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: "Add a comment...",
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: _submitComment,
            child: const Text("Post", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final Comment comment;

  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(comment.profileImage),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(text: "${comment.username} ", style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: comment.text),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      TimeFormatter.format(comment.timestamp),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(width: 16),
                    if (comment.likes > 0)
                      Text("${comment.likes} likes", style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 16),
                    const Text("Reply", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(comment.isLiked ? Icons.favorite : Icons.favorite_border, 
                 color: comment.isLiked ? Colors.red : Colors.grey, size: 14),
            onPressed: () => context.read<CommentProvider>().toggleCommentLike(comment.postId, comment.id),
          ),
        ],
      ),
    );
  }
}
