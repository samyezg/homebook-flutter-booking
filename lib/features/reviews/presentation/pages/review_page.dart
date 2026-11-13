import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/features/bookings/presentation/bookings_notifier.dart';
import 'package:homebook_app/features/reviews/domain/reviews_repository.dart';
import 'package:homebook_app/features/reviews/presentation/reviews_notifier.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';

class ReviewPage extends ConsumerStatefulWidget {
  const ReviewPage({super.key, required this.bookingId});

  final String bookingId;

  @override
  ConsumerState<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<ReviewPage> {
  var _rating = 5;
  late final TextEditingController _comment;
  var _submitting = false;

  @override
  void initState() {
    super.initState();
    _comment = TextEditingController();
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    try {
      ref.read(reviewsProvider.notifier).submit(
            bookingId: widget.bookingId,
            rating: _rating,
            comment: _comment.text,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.reviewSubmitted)),
      );
      context.pop();
    } on ReviewException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final booking = ref.watch(bookingByIdProvider(widget.bookingId));
    final existing = ref.watch(reviewByBookingIdProvider(widget.bookingId));

    if (booking == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.reviewTitle)),
        body: Center(child: Text(l10n.bookingMissing)),
      );
    }

    if (existing != null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.reviewTitle)),
        body: Center(child: Text(l10n.reviewAlreadySubmitted)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reviewServiceTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            booking.serviceName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.rating,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              for (var star = 1; star <= 5; star++)
                IconButton(
                  key: ValueKey('star-$star'),
                  onPressed: () => setState(() => _rating = star),
                  icon: Icon(
                    star <= _rating
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: AppColors.statusPending,
                    size: 32,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            key: const ValueKey('review-comment'),
            controller: _comment,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: l10n.commentOptional,
              hintText: l10n.commentHint,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: FilledButton(
            key: const ValueKey('submit-review'),
            onPressed: _submitting ? null : _submit,
            child: Text(_submitting ? l10n.submitting : l10n.submitReview),
          ),
        ),
      ),
    );
  }
}
