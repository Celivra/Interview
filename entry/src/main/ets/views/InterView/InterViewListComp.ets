import { InterviewItem, InterviewListParams, PageData } from '../../models/Index'
import { InterviewItemComp } from './InterViewListItemComp'
import { http } from '@kit.NetworkKit'
import { Res } from '../../models'

@Component
export struct InterviewListComp {
  @State isRefreshing: boolean = false
  @State isLoading: boolean = false
  @State isFinished: boolean = true
  @State params:InterviewListParams = {
    keyword:'',
    sort:30,
    page:1,
    questionBankType:9
  }
  @State list: InterviewItem[] = [ ]
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
        .onReachEnd(()=>{
          this.LoadData()
        })
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
  async LoadData () {
    this.isLoading = true
    const req = http.createHttp()
    const paramKeys: string[] = Object.keys(this.params)
    const paramValues: (number | string | boolean)[] = Object.values(this.params)
    const paramsStr = paramKeys.map((key,i) => `${key}=${paramValues[i]}`).join('&')
    const url = `https://api-harmony-teach.itheima.net/hm/question/list?${paramsStr}`
    const res = await req.request(url, {
      expectDataType: http.HttpDataType.OBJECT
    })
    const result = res.result as Res<PageData<InterviewItem>>
    this.list.push(...result.data.rows)
    this.isLoading = false
    if (this.params.page >= result.data.pageTotal) {
      this.isFinished = true
    } else {
      this.params.page ++
    }
  }
}
