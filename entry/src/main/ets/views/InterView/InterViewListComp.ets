import { InterviewItem } from '../../models/Index'
import { InterviewItemComp } from './InterViewListItemComp'

@Component
export struct InterviewListComp {
  @State isRefreshing: boolean = false
  @State isLoading: boolean = false
  @State isFinished: boolean = true
  @State list: InterviewItem[] = [
    {
      id: '10001',
      stem: '微软谷歌面试算法难度',
      content: '内推 候选人可以找到认识的微软员工,员工会把简历提交到微软人才库。这样微软HR就可以在人才库的系统中查看到你的简历。',
      likeCount: 13,
      views: 347,
      creatorName: '凡人的积累',
      creatorAvatar: $r('app.media.ic_interview_avatar'),
      createdAt: '2022-10-10',
      stage: ['大厂', '算法'],
      likeFlag: 1,
      collectFlag:0
    },
    {
      id: '10002',
      stem: '美团-工程效能组-开发工程师实习生-一面',
      content: '项目介绍网页音视频项目项目代码量多少？是一个人完成的吗？介绍SaaS视频项目SpringSpring框架有什么特性？(不知道这个问题要问什么，答的扩展性、封装性啥的)控制反转了解吗？',
      likeCount: 32,
      views: 503,
      creatorName: '响亮的名字',
      creatorAvatar: $r('app.media.ic_interview_avatar'),
      createdAt: '2022-10-10',
      stage: ['大厂', 'Java'],
      likeFlag: 0,
      collectFlag:0
    },
    {
      id: '10003',
      stem: '中邮消费金融AI算法',
      content: '这个是在猎聘上投递的 能收到面试属实是意外之喜面试官是nlp方向的，主要是问nlp相关 首先自我介绍说一个在上段实习中的项目 这里说了一个搭建智能客服对话助手',
      likeCount: 10,
      views: 98,
      creatorName: '不想秃头的夜猫子',
      creatorAvatar: $r('app.media.ic_interview_avatar'),
      createdAt: '2022-10-10',
      stage: ['国企', '实习'],
      likeFlag: 1,
      collectFlag:0
    }
  ]
  build() {
    Column(){
      Row({ space: 15 }){
        Text('推荐')
          .fontColor($r('app.color.black') )
        Text('最新')
          .fontColor($r('app.color.common_gray_01'))
      }
      .padding(15)
      .height(48)
      .width('100%')
      .border({ width: { bottom: 0.5 }, color: $r('app.color.common_gray_border') })
      Refresh({ refreshing: $$this.isRefreshing }){
        List() {
          ForEach(this.list, (item: InterviewItem) => {
            ListItem() {
              InterviewItemComp({ item })
            }
          })
          ListItem(){
            if (this.isFinished) {
              Text('没有更多了~')
                .fontSize(15)
                .fontColor($r('app.color.common_gray_01'))
            }else if (this.isLoading) {
              Row({ space: 4 }){
                LoadingProgress()
                  .width(24)
                  .aspectRatio(1)
                  .color($r('app.color.common_gray_02'))
                Text('正在加载...')
                  .fontSize(15)
                  .fontColor($r('app.color.common_gray_01'))
              }
            }
          }
          .height(80)
          .width('100%')
        }
        .width('100%')
        .height('100%')
        .divider({
          strokeWidth: 0.5,
          color: $r('app.color.common_gray_border'),
          startMargin: 15,
          endMargin: 15
        })
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
      }
      .onRefreshing(() => {
        setTimeout(() => {
          this.isRefreshing = false
        }, 2000)
      })
      .layoutWeight(1)
    }
    .width('100%')
    .layoutWeight(1)
  }
}