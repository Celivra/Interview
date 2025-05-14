interface CompanyItem {
  icon: ResourceStr
  count: number
}

@Component
export struct InterviewPage {
  @StorageProp('topHeight') topHeight: number = 0

  @Builder
  HeaderBuilder() {
    Row({ space: 15 }) {
      Image($r('app.media.ic_interview_text'))
        .height(24)
      Row({ space: 2 }) {
        Image($r('app.media.ic_common_search'))
          .width(14)
          .aspectRatio(1)
          .fillColor($r('app.color.common_gray_01'))
        Text('请输入关键字')
          .fontSize(15)
          .fontColor($r('app.color.common_gray_01'))
      }
      .justifyContent(FlexAlign.Center)
      .height(32)
      .borderRadius(16)
      .layoutWeight(1)
      .backgroundColor($r('app.color.common_gray_bg'))
    }
    .height(64 + this.topHeight)
    .width('100%')
    .padding({ left: 15, right: 15, top: this.topHeight })
  }

  companyList: CompanyItem[] = [
    { icon: $r('app.media.ic_company_hw'), count: 3.5 },
    { icon: $r('app.media.ic_company_wr'), count: 1.9 },
    { icon: $r('app.media.ic_company_gg'), count: 2.1 },
    { icon: $r('app.media.ic_company_zj'), count: 1.2 },
    { icon: $r('app.media.ic_company_wy'), count: 4.2 }
  ]

  @Builder
  CompanyBuilder() {
    List({ space: 10 }) {
      ForEach(this.companyList, (item: CompanyItem, i) => {
        ListItem() {
          Column({ space: 12 }) {
            Image(item.icon)
              .width(36)
              .aspectRatio(1)
              .margin({ top: 20 })
            Text() {
              Span('热门指数')
              Span(`${item.count}k`)
                .fontColor($r('app.color.common_green'))
            }
            .fontSize(13)
            .fontColor($r('app.color.common_gray_01'))

            Text('查看')
              .textAlign(TextAlign.Center)
              .fontSize(14)
              .height(30)
              .width(80)
              .borderRadius(8)
              .backgroundColor($r('app.color.common_gray_bg'))
          }
          .height(140)
          .width(100)
          .borderRadius(8)
          .backgroundColor($r('app.color.white'))
          .margin({
            left: i === 0 ? 15 : 0,
            right: i === this.companyList.length - 1 ? 15 : 0
          })
        }
      })
    }
    .scrollBar(BarState.Off)
    .listDirection(Axis.Horizontal)
    .width('100%')
    .height(160)
    .padding({ top: 10, bottom: 10 })
    .backgroundColor($r('app.color.common_gray_bg'))
  }

  build() {
    Column() {
      this.HeaderBuilder()
      this.CompanyBuilder()
    }
    .width('100%')
    .height('100%')
  }
}