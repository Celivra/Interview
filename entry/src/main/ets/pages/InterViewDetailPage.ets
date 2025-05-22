import { promptAction, router } from '@kit.ArkUI';
import { InterviewItem } from '../models';
import { NavComp } from '../component/NavComp';
import { TagComp } from '../component/TagComp';
import { webview } from '@kit.ArkWeb';
import { httpClient } from '../utils/HttpClient';
import { http } from '@kit.NetworkKit';

@Entry
@Component
struct InterviewDetailPage {
  @State detail: InterviewItem = {} as InterviewItem
  @State isLoading:boolean = true
  @StorageProp('bottomHeight') bottomHeight: number = 0
  aboutToAppear(): void {
    const params = router.getParams() as InterviewItem
    this.detail = params
    if(params){
      this.detail = params
      this.getData()
    }
  }
  async getData(){
    const data = await httpClient.request<InterviewItem>(`question/${this.detail.id}`,http.RequestMethod.GET)
    this.detail = data
    this.isLoading = false
    this.webViewController.runJavaScript(`writeHtml(\` ${this.detail.content} \`)`)
  }

  @Builder
  HeaderBuilder() {
    Column({ space: 15 }) {
      Text(this.detail.stem)
        .fontWeight(600)
        .fontSize(18)
        .padding({ left: 15, right: 15 })
        .width('100%')

      Row({ space: 4 }) {
        Image(this.detail.creatorAvatar)
          .width(36)
          .aspectRatio(1)
        Column({ space: 4 }) {
          Text(this.detail.creatorName)
            .fontSize(14)
          Text() {
            Span('浏览 ' + this.detail.views)
            Span(' · ')
            Span('点赞 ' + this.detail.likeCount)
            Span(' · ')
            Span(this.detail.createdAt)
          }
          .width('100%')
          .fontSize(12)
          .fontColor('#bdbdbd')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .padding({ left: 15, right: 15 })

      Row({ space: 4 }) {
        ForEach(['大厂', '面经'], (tag: string) => {
          TagComp({ tag })
        })
      }
      .width('100%')
      .padding({ left: 15, right: 15 })
    }
  }

  webViewController = new webview.WebviewController
  build() {
    Column() {
      NavComp()
      List() {
        ListItem() {
          this.HeaderBuilder()
        }
        ListItem(){
          Web({src:$rawfile('interview.html'),controller:this.webViewController})
            .onPageEnd(()=>{
              if(!this.isLoading){
                this.webViewController.runJavaScript(`writeHtml(\` ${this.detail.content} \`)`)

              }
            })
        }
      }
      .layoutWeight(1)
      .height('100%')
      .width('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
      this.ToolsBuilder()
    }
    .height('100%')
    .width('100%')
  }
  async opt(optType: 1 | 2, flag: 0 | 1) {
    await httpClient.request<Object>(
      flag === 1 ? 'question/opt' : 'question/unOpt',
      http.RequestMethod.POST,
      new Object({
        id: this.detail.id,
        type : 1,
        optType
      })
    )
    if (optType === 1) {
      this.detail.likeFlag = flag
      this.detail.likeCount += flag === 1 ? 1 : -1
      promptAction.showToast({ message: flag ? '点赞成功' : '取消点赞' })
    }
    if (optType === 2) {
      this.detail.collectFlag = flag
      promptAction.showToast({ message: flag ? '收藏成功' : '取消收藏' })
    }
  }
  @Builder
  ToolsBuilder() {
    Row() {
      ToolsItemComp({ icon: $r('app.media.ic_public_share'), text: '分享' })
      ToolsItemComp({ icon: $r('app.media.ic_public_like'), text: '点赞', isActive:this.detail.likeFlag === 1})
        .onClick(()=>{
          this.opt(1,this.detail.likeFlag === 1?0:1)
        })
      ToolsItemComp({ icon: $r('app.media.ic_public_collect'), text: '收藏',isActive:this.detail.collectFlag === 1 })
        .onClick(()=>{
          this.opt(2,this.detail.collectFlag === 1?0:1)
        })
      ToolsItemComp({ icon: $r('app.media.ic_public_sound'), text: '朗读' })
    }
    .justifyContent(FlexAlign.SpaceAround)
    .height(50 + this.bottomHeight)
    .padding({ left: 15, right: 15, bottom: this.bottomHeight })
    .width('100%')
    .border({ width: { top: 0.5 }, color: $r('app.color.common_gray_border') })
  }
}

@Component
struct ToolsItemComp {
  @Prop @Require icon: ResourceStr
  @Prop @Require text: string
  @Prop isActive: boolean = false
  build() {
    Row({ space: 2 }) {
      Image(this.icon)
        .width(20)
        .aspectRatio(1)
        .fillColor(this.isActive ? $r('app.color.common_main_color') : $r('app.color.common_gray_02'))
      Text(this.text)
        .fontColor(this.isActive ? $r('app.color.common_main_color') : $r('app.color.common_gray_02'))
        .fontSize(14)
    }
  }
}