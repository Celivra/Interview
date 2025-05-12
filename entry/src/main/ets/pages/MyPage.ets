import { faceDetector } from "@kit.CoreVisionKit"
import { router } from "@kit.ArkUI"

interface NavItem{
  icon:Resource,
  text:string
}
@Component
export struct MyPage{
  isLogin:boolean = false
  @Builder
  ToolsBuilder(item:NavItem){
    Row({space:4}){
      Image(item.icon)
        .width(16)
        .aspectRatio(1)
      Text(item.text)
        .fontSize(14)
        .fontColor(Color.Black)
      Blank()
      Image($r('sys.media.ohos_ic_public_arrow_right'))
        .width(24)
        .aspectRatio(1)
        .fillColor($r('app.color.common_gray_01'))
    }
    .width('100%')

  }
  @Builder
  NavBuilder(item:NavItem){
    Column({space:4}){
      Image(item.icon)
        .width(30)
        .aspectRatio(1)
      Text(item.text)
        .fontSize(14)
        .fontColor($r('app.color.common_gray_03'))
    }
  }
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
            Text('立即登录')
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
              .maxLines(1)
              .onClick(()=>{
                router.pushUrl({url:'pages/LoginPage'})
              })
          }
        }
      }
      .height(160)
      .width('100%')
      //nav
      Row(){
        this.NavBuilder({icon:$r('app.media.ic_mine_history'), text:'历史记录'})
        this.NavBuilder({icon:$r('app.media.ic_mine_collect'), text:'我的收藏'})
        this.NavBuilder({icon:$r('app.media.ic_mine_like'),    text:'我的点赞'})
        this.NavBuilder({icon:$r('app.media.ic_mine_study'),   text:'累计学时'})
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(15)
      .borderRadius(8)
      .backgroundColor(Color.White)
      .width('100%')
      //tools
      Column({space:25}){
        this.ToolsBuilder({icon:$r('app.media.ic_mine_notes'),  text:'开发常用词语'})
        this.ToolsBuilder({icon:$r('app.media.ic_mine_file'),   text:'意见反馈'})
        this.ToolsBuilder({icon:$r('app.media.ic_mine_info'),   text:'关于我们'})
        this.ToolsBuilder({icon:$r('app.media.ic_mine_setting'),text:'设置'})
      }
      .padding(15)
      .margin({top:15})
      .borderRadius(8)
      .backgroundColor(Color.White)
      .width('100%')

      //logout
      Text('退出登录')
        .fontColor($r('app.color.common_main_color'))
        .margin({top:15})
    }
    .width('100%')
    .height('100%')
    .padding(15)
    .linearGradient({colors:[
      ['#ffb071', 0],
      [$r('app.color.common_gray_bg'), 0.3],
      [$r('app.color.common_gray_bg'), 1]
    ]})
  }
}