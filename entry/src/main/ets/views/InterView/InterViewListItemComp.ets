import { InterviewItem } from '../../models/Index'

@Component
export  struct InterviewItemComp {
  item: InterviewItem = {} as InterviewItem
  build() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Image(this.item.creatorAvatar)
          .width(36)
          .aspectRatio(1)
        Column({ space: 4 }) {
          Text(this.item.stem)
            .fontWeight(600)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text() {
            Span(this.item.creatorName)
            Span(' · ')
            Span(this.item.createdAt)
          }
          .fontSize(10)
          .fontColor('#bdbdbd')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Image($r('app.media.ic_interview_more'))
          .width(20)
          .aspectRatio(1)
          .alignSelf(ItemAlign.Start)
      }
      Text(this.item.content)
        .fontSize(14)
        .fontColor($r('app.color.common_gray_02'))
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .lineHeight(24)
        .width('100%')

      Row({ space: 8 }) {
        ForEach(['大厂', '面经'], (tag: string) => {
          Text(tag)
            .fontSize(10)
            .fontColor($r('app.color.common_green'))
            .backgroundColor($r('app.color.common_blue_bg'))
            .padding({
              top: 2,
              bottom: 2,
              left: 6,
              right: 6
            })
            .borderRadius(2)
        })
      }
      .width('100%')

      Text() {
        Span('点赞 ' + this.item.likeCount)
        Span(' · ')
        Span('浏览 ' + this.item.views)
        if (this.item.likeFlag === 1) {
          Span(' · ')
          Span('已点赞')
        }
      }
      .width('100%')
      .fontSize(12)
      .fontColor('#bdbdbd')
    }
    .padding(15)
  }
}