import { auth } from '../utils/Auth'
import { HomePage } from './HomePage'
import { InterviewPage } from './InterviewPage'
import { MyPage } from './MyPage'
import { ProjectPage } from './ProjectPage'

interface TabItem{
  icon:Resource,
  activeIcon:Resource,
  name:string
}
auth.initUser()

@Entry
@Component
struct Index {
  @StorageProp('bottomHeight') bottomHeight:number = 0
  tabList:TabItem[] = [
    {
      icon:$r('app.media.tabbar_home'),
      activeIcon:$r('app.media.tabbar_home_fill'),
      name:'首页'
    },
    {
      icon:$r('app.media.tabbar_project'),
      activeIcon:$r('app.media.tabbar_project_fill'),
      name:'项目'
    },
    {
      icon:$r('app.media.tabbar_interview'),
      activeIcon:$r('app.media.tabbar_interview_fill'),
      name:'面经'
    },
    {
      icon:$r('app.media.tabbar_mine'),
      activeIcon:$r('app.media.tabbar_mine_fill'),
      name:'我的'
    },
  ]
  @State activeIndex:number=0
  @Builder
  TabBuilder(item:TabItem, i:number){
    Column(){
      Image(this.activeIndex === i? item.activeIcon:item.icon)
        .width(24)
        .aspectRatio(1)
      Text(item.name)
        .fontSize(12)
        .fontColor(this.activeIndex === i?$r('app.color.black'):$r('app.color.common_gray_02'))
    }
  }
  build() {
    Column({space:20}){
      Tabs({barPosition:BarPosition.End, index:this.activeIndex}){
        ForEach(this.tabList, (item:TabItem, i)=>{

          TabContent(){
            if(i === 0) HomePage();
            else if(i === 1) ProjectPage();
            else if(i === 2) InterviewPage();
            else MyPage();
          }
          .tabBar(this.TabBuilder(item, i))
        })
      }
      .onTabBarClick((i=>{ this.activeIndex = i; }))
      .divider({strokeWidth:1, color:$r('app.color.common_gray_border')})
      .padding({bottom:this.bottomHeight})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}