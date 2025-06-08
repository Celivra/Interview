@Component
export struct HomePage {
  @StorageProp('topHeight') topHeight: number = 0

  @Builder
  HeaderView() {
    Row() {
      Column() {}
      .width(40) .height(40)
      .backgroundColor("#E0E0E0") .borderRadius(20)
      .margin({ left: 16, right: 12 })
      Row({ space: 8 }) {
        Image($r('app.media.ic_common_search'))
          .width(18) .height(18) .fillColor("#888888")
        Text('请输入关键字') .fontSize(16) .fontColor("#888888")
      }
      .justifyContent(FlexAlign.Center)
      .height(40)
      .borderRadius(20)
      .layoutWeight(1)
      .backgroundColor("#F5F5F5")
      .padding({ left: 12, right: 12 })
      Text("打卡") .fontSize(16) .fontWeight(FontWeight.Medium)
        .fontColor("#333333") .padding({ left: 16, right: 16 })
        .border({ width: 1, color: "#E0E0E0", radius: 20 })
        .margin({ right: 16 })
    }
    .height(64 + this.topHeight) .width('100%')
    .padding({ top: this.topHeight })
    .backgroundColor("#FFFFFF")
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BannerView() {
    Column() {
      Text('Featured Content') .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor("#FFFFFF")
    }
    .width("90%") .height(180) .borderRadius(16)
    .justifyContent(FlexAlign.Center) .alignItems(HorizontalAlign.Center)
    .backgroundColor("#4A90E2") .margin({ bottom: 24 })
    .shadow({ radius: 8, color: "#20000000", offsetX: 0, offsetY: 4 })
  }
  @Builder
  ListItem(index: number) {
    Column() {
      Row() {
        Text(`Item ${index}`) .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor("#333333")
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width("100%")
      Divider() .strokeWidth(1) .color("#F0F0F0")
        .margin({ top: 12, bottom: 12 })
    }
    .width("90%") .padding(16) .backgroundColor("#FFFFFF")
    .borderRadius(12) .margin({ bottom: 12 })
    .shadow({ radius: 2, color: "#10000000", offsetX: 0, offsetY: 2 })
  }
  build() {
    Column() {
      this.HeaderView()
      Scroll() {
        Column() {
          this.BannerView()
          Column() {
            ForEach([1, 2, 3, 4], (index: number) => {
              this.ListItem(index)
            })
          } .width("100%")
          .alignItems(HorizontalAlign.Center)
        }
      }
      .width("100%") .layoutWeight(1) .backgroundColor("#FAFAFA")
    }
    .width('100%') .height('100%')
  }
}