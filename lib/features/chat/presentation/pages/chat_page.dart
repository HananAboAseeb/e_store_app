import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../cubit/agent_chat_cubit.dart';
import '../cubit/agent_chat_state.dart';
import '../cubit/chat_bot_cubit.dart';
import '../cubit/chat_bot_state.dart';
import '../widgets/chat_bottom_input.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_issue_chip.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_order_card.dart';
import '../widgets/chat_review_sheet.dart';
import '../widgets/chat_scroll_to_bottom_button.dart';
import '../widgets/chat_typing_indicator.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatBotCubit _chatBotCubit;
  late final AgentChatCubit _agentChatCubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _chatBotCubit = sl<ChatBotCubit>()..loadBotFlow();
    _agentChatCubit = sl<AgentChatCubit>();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // If user has scrolled up past 120dp from bottom
    final isScrolledUp = (maxScroll - currentScroll) > 120.h;
    _agentChatCubit.updateScrollToBottomVisibility(isScrolledUp);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _handleClose(
    BuildContext context,
    AgentChatState agentState,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    // If user is already in agent conversation, show review sheet on close
    if (_chatBotCubit.state.step == ChatBotStep.completed) {
      final reviewed = await ChatReviewSheet.show(
        context,
        agent: agentState.agent,
      );
      if (mounted) {
        if (reviewed == true) {
          messenger.showSnackBar(
            const SnackBar(
              content: Text('Thank you for rating our service!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        router.pop();
      }
    } else {
      router.pop();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _chatBotCubit.close();
    _agentChatCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _chatBotCubit),
        BlocProvider.value(value: _agentChatCubit),
      ],
      child: BlocBuilder<ChatBotCubit, ChatBotState>(
        builder: (context, botState) {
          return BlocConsumer<AgentChatCubit, AgentChatState>(
            listenWhen: (previous, current) =>
                previous.messages.length != current.messages.length ||
                (previous.isTyping != current.isTyping && current.isTyping),
            listener: (context, agentState) {
              // Auto scroll to bottom ONLY when new messages arrive or agent starts typing
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollToBottom();
              });
            },
            builder: (context, agentState) {
              final isBotStep = botState.step != ChatBotStep.completed;
              final isConnecting =
                  agentState.phase == AgentChatPhase.connecting;
              final showBotHeader = isBotStep || isConnecting;

              return Scaffold(
                backgroundColor: AppColors.white,
                body: Stack(
                  children: [
                    // Top Blue Fade Asset from assets/images/background/
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/background/blue fade top.png',
                        fit: BoxFit.fitWidth,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),
                    ),

                    // Bottom Blue Fade Asset from assets/images/background/
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/background/blue fade bottom.png',
                        fit: BoxFit.fitWidth,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),
                    ),

                    // Main Foreground Content
                    SafeArea(
                      child: Column(
                        children: [
                          // Top Chat Header (Screens 68–79)
                          ChatHeader(
                            title: showBotHeader
                                ? 'Chat Bot'
                                : agentState.agent.name,
                            subtitle: 'Customer Care Service',
                            avatarUrl: showBotHeader
                                ? 'assets/images/ShopX_logo.png'
                                : agentState.agent.avatarUrl,
                            isBot: showBotHeader,
                            onClose: () => _handleClose(context, agentState),
                          ),

                          // Center Content Area (Triage OR Message List)
                          Expanded(
                            child: isBotStep
                                ? _buildBotTriageContent(context, botState)
                                : _buildAgentConversationContent(
                                    context,
                                    agentState,
                                  ),
                          ),

                          // Bottom Floating Input Bar in live agent conversation
                          if (!isBotStep)
                            ChatBottomInput(
                              isEnabled: !isConnecting,
                              onSend: (text) =>
                                  _agentChatCubit.sendUserMessage(text),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBotTriageContent(BuildContext context, ChatBotState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Initial Bot Welcome Bubble (Screens 68, 69, 70)
          ChatMessageBubble(
            message: ChatMessageEntity(
              id: 'welcome_msg',
              sender: ChatMessageSender.bot,
              text: state.welcomeMessage.isNotEmpty
                  ? state.welcomeMessage
                  : 'Hello, Amanda! Welcome to Customer Care Service. We will be happy to help you. Please, provide us more details about your issue before we can start.',
              timestamp: '12:34',
            ),
          ),
          SizedBox(height: 12.h),

          // White Rounded Card Container enclosing triage questions (Width: 342, compact hugging content, Radius: 25)
          Container(
            width: 342.w,
            padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 20.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Triage Question Title (Raleway, 700, 18sp)
                AppText.h2(
                  _getQuestionTitle(state.step),
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 14.h),

                // Triage Options
                if (state.step == ChatBotStep.issue) ...[
                  // Screen 68: 5 chips
                  ...state.issueCategories.map(
                    (category) => ChatIssueChip(
                      label: category,
                      isSelected: state.selectedIssue == category,
                      onTap: () => _chatBotCubit.selectIssue(category),
                    ),
                  ),
                ] else if (state.step == ChatBotStep.orderIssue) ...[
                  // Screen 69: 5 chips
                  ...state.orderIssues.map(
                    (orderIssue) => ChatIssueChip(
                      label: orderIssue,
                      isSelected: state.selectedOrderIssue == orderIssue,
                      onTap: () =>
                          _chatBotCubit.selectOrderIssue(orderIssue),
                    ),
                  ),
                ] else if (state.step == ChatBotStep.selectOrder) ...[
                  // Screen 70: Order cards (Width ~294, Height ~80, radius 16)
                  ...state.orders.map(
                    (order) => ChatOrderCard(
                      order: order,
                      isInteractive: true,
                      onSelect: () => _chatBotCubit.selectOrder(order),
                    ),
                  ),
                ],

                // Fixed, tight gap between options and Next button row
                SizedBox(height: 14.h),

                // Bottom Action Buttons inside the white card (Next: width 294, height 48, radius 24)
                Row(
                  children: [
                    // Back button on Screen 69 & 70
                    if (state.step != ChatBotStep.issue) ...[
                      GestureDetector(
                        onTap: () => _chatBotCubit.back(),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE5E7EB),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: 22.sp,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],

                    // Next button (height: 48, radius: 24)
                    Expanded(
                      child: PrimaryButton(
                        text: 'Next',
                        height: 48.h,
                        borderRadius: BorderRadius.circular(24.r),
                        onPressed: () {
                          if (state.step == ChatBotStep.selectOrder) {
                            final selectedOrder = state.selectedOrder ??
                                (state.orders.isNotEmpty
                                    ? state.orders.first
                                    : null);
                            if (selectedOrder != null) {
                              _chatBotCubit.next();
                              _agentChatCubit.startAgentHandoff(
                                issueCategory: state.selectedIssue,
                                orderIssue: state.selectedOrderIssue,
                                selectedOrder: selectedOrder,
                              );
                            }
                          } else {
                            _chatBotCubit.next();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildAgentConversationContent(
    BuildContext context,
    AgentChatState agentState,
  ) {
    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          itemCount: agentState.messages.length +
              (agentState.phase == AgentChatPhase.connecting ? 1 : 0) +
              (agentState.isTyping ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < agentState.messages.length) {
              final message = agentState.messages[index];
              final isFirstUserMessage =
                  message.sender == ChatMessageSender.user && index == 1;

              final hasNextFromSameSender =
                  (index + 1 < agentState.messages.length) &&
                      (agentState.messages[index + 1].sender == message.sender);
              final showTimestamp = !hasNextFromSameSender;

              return ChatMessageBubble(
                message: message,
                showUserAvatar: isFirstUserMessage,
                showTimestamp: showTimestamp,
              );
            }

            // Connecting with agent indicator (Screen 71)
            if (agentState.phase == AgentChatPhase.connecting &&
                index == agentState.messages.length) {
              return const ChatTypingIndicator(
                label: 'Connecting with an Agent',
              );
            }

            // Agent typing indicator (Screen 72, 73)
            return const ChatTypingIndicator(label: 'Typing');
          },
        ),

        // Soft white fade gradient at top of message list (Screen 77)
        // Hidden/scrolled messages smoothly fade out as they reach the header
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 36.h,
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white.withOpacity(0.95),
                    AppColors.white.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Floating Scroll-To-Bottom Button (Screen 78)
        if (agentState.showScrollToBottom)
          Positioned(
            right: 24.w,
            bottom: 12.h,
            child: ChatScrollToBottomButton(
              onTap: _scrollToBottom,
            ),
          ),
      ],
    );
  }

  String _getQuestionTitle(ChatBotStep step) {
    switch (step) {
      case ChatBotStep.issue:
        return "What's your issue?";
      case ChatBotStep.orderIssue:
        return 'Order Issues';
      case ChatBotStep.selectOrder:
        return 'Select your Order';
      case ChatBotStep.completed:
        return '';
    }
  }
}
