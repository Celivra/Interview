@Component
export struct MyPage{
  isLogin:boolean = true
  build() {
    Column(){
      //head
      Row({space:15}){

        Image($r('app.media.ic_mine_avatar'))
          .alt($r('app.media.ic_mine_avatar'))
          .width(55)
          .aspectRatio(1)
          .borderRadius(30)
        if (this.isLogin){
          Column(){
            Text('黑马程序员')
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
              .maxLines(1)
            Row(){
              Text('编辑信息')
                .fontSize(12)
                .fontColor($r('app.color.common_gray_01'))
              Image($r('app.media.ic_mine_edit'))
                .width(12)
                .fillColor($r('app.color.common_gray_02'))
            }
          }
          .alignItems(HorizontalAlign.Start)
        }else {
          Column(){
            Text('立即登入')
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
              .maxLines(1)
          }
        }
      }
      .height(160)
      .width('100%')
      //nav
      //tools
    }
    .width('100%')
    .height('100%')
    .padding(15)
  }
}