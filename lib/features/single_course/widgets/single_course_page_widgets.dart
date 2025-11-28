import 'package:leti_mobile/widget_imports.dart';

class SkillLevelTimeToCompleteCertificatesPrereqs extends StatelessWidget {
  final SingleCourseState state;

  const SkillLevelTimeToCompleteCertificatesPrereqs({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            CourseTopLevelHeaderAndSubHeader(
              headlineLeft: context.localizations.skillLevel,
              textLeft: state.fullCourseInfo.level?.label ?? '',
              isLeft: true,
            ),
            SizedBox(height: 20.h),
            CourseTopLevelHeaderAndSubHeader(
              headlineLeft: context.localizations.certificateOfCompletion,
              textLeft: 'fsdf',
              isLeft: true,
            ),
          ],
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CourseTopLevelHeaderAndSubHeader(
              //   headlineLeft: context.localizations.timeToComplete,
              //   textLeft: state.fullCourseInfo.completionTime ?? '',
              //   isLeft: false,
              // ),
              SizedBox(height: 20.h),
              // CourseTopLevelHeaderAndSubHeader(
              //   headlineLeft: context.localizations.prerequisities,
              //   textLeft: state.fullCourseInfo.prerequisites ?? '',
              //   isLeft: false,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class ShowMoreTextWithOpacity extends StatelessWidget {
  final String text;
  final bool isDescriptionHidden;

  const ShowMoreTextWithOpacity({
    super.key,
    required this.text,
    required this.isDescriptionHidden,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SingleCourseBloc>().manageDescriptionHidden();
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isDescriptionHidden
                ? Icons.keyboard_arrow_down_outlined
                : Icons.keyboard_arrow_up_outlined,
          ),
          SizedBox(width: 8.w),
          Text(
            isDescriptionHidden ? text : 'Hide',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableHtml extends StatelessWidget {
  final String html;
  final SingleCourseState state;

  const ExpandableHtml({super.key, required this.html, required this.state});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: SizedBox(
        height: 150.h,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: HtmlWidget(html),
        ),
      ),
      secondChild: HtmlWidget(html),
      crossFadeState: state.isDescriptionHidden
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class ExpandableCourseMaterials extends StatelessWidget {
  final SingleCourseState state;

  const ExpandableCourseMaterials({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: SizedBox(
        height: 300.h,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemCount: state.courseMaterialsAreHidden
              ? 3
              : state.fullCourseInfo.syllabus?.courseContent?.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final title = state.fullCourseInfo.syllabus?.courseContent?[index];

            return CourseInfoMaterialExpansionItem(
              title: title?.title ?? '',
              subTitle: title?.description ?? '',
              chapterInfoText: title?.topics.map((e) => e.title).toList() ?? [],
              lessonsLength: title?.topics.length ?? 0,
              topics: title?.topics ?? [],
            );
          },
        ),
      ),
      secondChild: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: state.fullCourseInfo.syllabus?.courseContent?.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final title = state.fullCourseInfo.syllabus?.courseContent?[index];

          return CourseInfoMaterialExpansionItem(
            title: title?.title ?? '',
            subTitle: title?.description ?? '',
            chapterInfoText: title?.topics.map((e) => e.title).toList() ?? [],
            lessonsLength: title?.topics.length ?? 0,
            topics: title?.topics ?? [],
          );
        },
      ),
      crossFadeState: state.courseMaterialsAreHidden
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class CourseInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int id;

  const CourseInfoAppBar({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          backgroundColor: state.isLightTheme
              ? context.colors.status03ContainerDefault.withOpacity(0.1)
              : Color(0XFF9E8FF9).withOpacity(0.2),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 16.w),
              CustomAppBarBackButton(),
              Spacer(),
              BlocBuilder<SingleCourseBloc, SingleCourseState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      context.read<SingleCourseBloc>().postCourseAsFavorite(id);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: (state.isFavorite)
                        ? Assets.icons.courses.heartFilled.svg(
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.primary,
                              BlendMode.srcIn,
                            ),
                          )
                        : Assets.icons.courses.heart.svg(),
                  );
                },
              ),
              SizedBox(width: 16.w),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CourseInfoAuthorDetails extends StatelessWidget {
  final String authorName;
  final String authorPhoto;
  final String authorPosition;
  final VoidCallback onTap;
  final int courseCount;
  final String about;

  const CourseInfoAuthorDetails({
    super.key,
    required this.authorName,
    required this.authorPhoto,
    required this.authorPosition,
    required this.onTap,
    required this.courseCount,
    required this.about,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  authorPhoto,
                  width: 40.w,
                  height: 40.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: context.colors.neutralContainerDefault
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 40.w,
                      height: 40.w,
                      child: Center(
                        child: Text(authorName.isNotEmpty ? authorName[0] : ''),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                  Text(
                    authorPosition,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.5,
                      color: context.colors.fgSoft,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              // Spacer(),
              // GestureDetector(
              //   onTap: onTap,
              //   behavior: HitTestBehavior.opaque,
              //   child: Assets.icons.courses.arrowRight.svg(),
              // ),
            ],
          ),
          SizedBox(height: 16.h),
          CourseInfoAuthorsCoursesRatings(coursesCount: courseCount, rating: 5),
          SizedBox(height: 16.h),
          Text(about, style: TextStyle(height: 1.2.h)),
        ],
      ),
    );
  }
}

class CourseInfoAuthorsCoursesRatings extends StatelessWidget {
  final int coursesCount;
  final double rating;

  const CourseInfoAuthorsCoursesRatings({
    super.key,
    required this.coursesCount,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 2.w,
          color: Theme.of(context).colorScheme.tertiaryContainer,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.courses.videoCircle.image(width: 16.w, height: 16.w),
            SizedBox(width: 4.w),
            Text(
              '$coursesCount ${context.localizations.coursesWithnumber}',
              style: TextStyle(fontSize: 13.sp),
            ),
            SizedBox(width: 45.w),
            VerticalDivider(
              color: context.colors.borderMuted.withOpacity(0.15),
              width: 2,
              thickness: 2,
            ),
            SizedBox(width: 45.w),
            Assets.icons.homeTabIcons.star.image(width: 16.w, height: 16.w),
            SizedBox(width: 4.w),
            Text('$rating Rating', style: TextStyle(fontSize: 13.sp)),
          ],
        ),
      ),
    );
  }
}

class CourseAuthorsItem extends StatelessWidget {
  final String image;
  final String name;
  final String occupation;

  const CourseAuthorsItem({
    super.key,
    required this.image,
    required this.name,
    required this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: image,
              width: 32.w,
              height: 32.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 32.w,
                height: 32.w,
                color: context.colors.neutralContainerDefault.withOpacity(0.1),
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: context.colors.neutralContainerDefault.withOpacity(
                    0.1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(child: Text(name[0])),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            name,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 8.w),
          SizedBox(
            width: 110.w,
            child: Text(
              occupation,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: context.colors.fgMuted,
                letterSpacing: -0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class CourseInfoBigHeadline extends StatelessWidget {
  final String text;
  final bool isLeft;

  const CourseInfoBigHeadline({
    super.key,
    required this.text,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isLeft ? 166.w : 135.w,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.5,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class CourseInfoBlocsTitle extends StatelessWidget {
  final String text;

  const CourseInfoBlocsTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: -1,
      ),
    );
  }
}

class CourseInfoBottomNavigator extends StatelessWidget {
  const CourseInfoBottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        // top: 12.h,
      ),
      // height: 100,
      height: 120.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ActionButton(text: context.localizations.buy, onTap: () {}),
          space8,
          ActionButton(
            text: context.localizations.tryForFree,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.webView);
            },
            isFilled: false,
          ),
        ],
      ),
    );
  }
}

class CourseInfoChapterInfoText extends StatelessWidget {
  const CourseInfoChapterInfoText({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h, left: 12.w, top: 4.h),
        child: Text(
          text,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class CourseInfoDivider extends StatelessWidget {
  const CourseInfoDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.h,
      height: 1.h,
      color: Color(0xFF525252).withOpacity(0.25),
    );
  }
}

class CourseInfoHeader extends StatelessWidget {
  const CourseInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
        return Container(
          color: homeState.isLightTheme
              ? context.colors.status03ContainerDefault.withOpacity(0.1)
              : Color(0XFF9E8FF9).withOpacity(0.2),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<SingleCourseBloc, SingleCourseState>(
            builder: (context, state) {
              final item = state.fullCourseInfo;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  space20,
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1.5,
                    ),
                  ),
                  space16,
                  Text(
                    item.shortDescription,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                      color: Theme.of(context).colorScheme.surfaceTint,
                    ),
                  ),
                  if (item.authors.isNotEmpty) ...[
                    space24,
                    Text(
                      context.localizations.authors.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: context.colors.fgMuted,
                      ),
                    ),
                    space8,
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: item.authors.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final authorItem = item.authors[index];
                        return CourseAuthorsItem(
                          image: authorItem.avatar?.original_url ?? '',
                          name:
                              '${authorItem.firstname} ${authorItem.lastname}',
                          occupation: authorItem.jobPosition,
                        );
                      },
                    ),
                  ],
                  space24,
                  CourseInfoSmallHeadline(text: 'PRICE'),
                  Row(
                    children: [
                      Text(
                        '${20000} UZS',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: homeState.isLightTheme
                              ? context.colors.accentContainerDefault
                                    .withOpacity(0.1)
                              : Color(0XFF47ADFF).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '35%',
                              style: TextStyle(
                                color: homeState.isLightTheme
                                    ? Theme.of(context).colorScheme.primary
                                    : Color(0XFF8CCBFF),
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              ' off',
                              style: TextStyle(
                                color: homeState.isLightTheme
                                    ? Theme.of(context).colorScheme.primary
                                    : Color(0XFF8CCBFF),
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '1 250 000 UZS',
                    style: TextStyle(
                      fontSize: 14.sp,
                      decoration: TextDecoration.lineThrough,
                      color: context.colors.fgMuted,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  space24,
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class CourseTopLevelHeaderAndSubHeader extends StatelessWidget {
  final String headlineLeft;
  final String textLeft;
  final bool isLeft;

  const CourseTopLevelHeaderAndSubHeader({
    super.key,
    required this.headlineLeft,
    required this.textLeft,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CourseInfoSmallHeadline(text: headlineLeft.toUpperCase()),
        CourseInfoBigHeadline(text: textLeft, isLeft: isLeft),
      ],
    );
  }
}

class CourseInfoMaterialExpansionItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final List<String> chapterInfoText;
  final int lessonsLength;
  final List<CourseTopicsResponse> topics;

  const CourseInfoMaterialExpansionItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.chapterInfoText,
    required this.lessonsLength,
    required this.topics,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: Border(),
      tilePadding: EdgeInsets.symmetric(vertical: 0.h),
      title: Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: Text(
          title,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Icon(Icons.keyboard_arrow_down_outlined),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(color: Theme.of(context).colorScheme.surfaceTint),
        maxLines: 1,
      ),
      children: <Widget>[
        Divider(
          thickness: 1.h,
          color: context.colors.borderMuted.withOpacity(0.15),
        ),
        space12,
        ListView.separated(
          itemCount: lessonsLength,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final topic = topics[index];
            final chapterID = topic.chapterId;
            final courseID = topic.courseId;

            return CourseInfoChapterInfoText(
              onTap: () {},
              text: chapterInfoText[index],
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Divider(color: context.colors.borderMuted.withOpacity(0.15)),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}

class CourseInfoShowAllButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isPaddingNeeded;

  const CourseInfoShowAllButton({
    super.key,
    required this.onTap,
    this.isPaddingNeeded = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: isPaddingNeeded ? 16.w : 0.w),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius.r)),
          border: Border.all(
            color: context.colors.borderMuted.withOpacity(0.15),
            width: 2.w,
          ),
        ),
        child: Center(
          child: Text(
            context.localizations.showAll,
            style: TextStyle(
              fontSize: 16.sp,
              color: context.colors.accentOnContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class ShowAllButtonWithChangingText extends StatelessWidget {
  final VoidCallback onTap;
  final bool isHidden;

  const ShowAllButtonWithChangingText({
    super.key,
    required this.onTap,
    required this.isHidden,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius.r)),
          border: Border.all(
            color: context.colors.borderMuted.withOpacity(0.15),
            width: 2.w,
          ),
        ),
        child: Center(
          child: Text(
            isHidden ? context.localizations.showAll : 'Hide',
            style: TextStyle(
              fontSize: 16.sp,
              color: context.colors.accentOnContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class CourseInfoSmallHeadline extends StatelessWidget {
  final String text;

  const CourseInfoSmallHeadline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
        color: context.colors.fgMuted,
      ),
    );
  }
}

class CourseInfoWhatYouWillLearnItems extends StatelessWidget {
  final String text;

  const CourseInfoWhatYouWillLearnItems({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Assets.icons.courses.tickCircle.svg(
              height: 20.w,
              width: 24.w,
              colorFilter: ColorFilter.mode(
                context.colors.fgMuted,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8.h),
            SizedBox(width: 296.w, child: Text(text)),
          ],
        ),
        space16,
      ],
    );
  }
}

class HeadlineAndViewAllWidget extends StatelessWidget {
  final String text;
  final VoidCallback viewAllOnTap;

  const HeadlineAndViewAllWidget({
    super.key,
    required this.text,
    required this.viewAllOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 17.sp,
            letterSpacing: -1,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: viewAllOnTap,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            // width: 85.w,
            child: Text(
              context.localizations.viewAll,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
