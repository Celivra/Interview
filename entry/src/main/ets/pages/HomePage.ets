@Component
export struct HomePage{
  @StorageProp('topHeight') topHeight: number = 0
  @Builder
  HeaderView(){
    Row(){
      Column(){}
      .backgroundColor("#bbb")
      .width(32)
      .aspectRatio(1.3)
      .borderRadius(15)
      .margin(10)
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
      Text("打卡")
        .fontSize(20)
        .padding({left:10, right:10, top:5, bottom:5})
        .border({
          width:1,
          color:0xbbbbbb,
          radius:15
        })
    }
    .height(64 + this.topHeight)
    .width('100%')
    .padding({ left: 15, right: 15, top: this.topHeight })
  }
  @Builder
  ListView(){
    Row(){
      Text('Component Context')
        .fontSize(14)
    }
    .width("90%")
    .height(70)
    .border({
      width:1,
      color:0xbbbbbb,
      radius:15
    })
    .justifyContent(FlexAlign.Center)
    .margin({bottom:10})
  }
  build() {
    Column(){
      this.HeaderView()
      Row(){
        Text('Banner')
          .fontSize(24)
      }
      .width("90%")
      .height(200)
      .border({
        width:1,
        color:0xbbbbbb,
        radius:15
      })
      .justifyContent(FlexAlign.Center)
      .margin({bottom:40})

      this.ListView()
      this.ListView()
      this.ListView()
      this.ListView()

    }
    .width('100%')
    .height('100%')
  }
}