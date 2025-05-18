import { InterviewItem, InterviewListParams, PageData } from '../../models/Index'
import { InterviewItemComp } from './InterViewListItemComp'
import { http } from '@kit.NetworkKit'
import { promptAction, router } from '@kit.ArkUI'
import { httpClient } from '../../utils/HttpClient'
import { auth } from '../../utils/Auth'

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
          .fontColor(this.params.sort === 30 ? $r('app.color.black') : $r('app.color.common_gray_01') )
          .onClick(() => {
            this.params.sort = 30
            this.refreshData()
          })
        Text('最新')
          .fontColor(this.params.sort === 0 ? $r('app.color.black') : $r('app.color.common_gray_01') )
          .onClick(() => {
            this.params.sort = 0
            this.refreshData()
          })
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
            .onClick(()=>{
              auth.checkAuth({url:"pages/InterViewDetailPage",params:new Object({stem:item.stem})})
            })
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
        this.refreshData()
      })
      .layoutWeight(1)
    }
    .width('100%')
    .layoutWeight(1)
  }

  async refreshData() {
    this.params.page = 1
    this.isRefreshing = true
    // const req = http.createHttp()
    // const paramKeys: string[] = Object.keys(this.params)
    // const paramValues: (number | string | boolean)[] = Object.values(this.params)
    // const paramsStr = paramKeys.map((key,i) => `${key}=${paramValues[i]}`).join('&')
    // const url = `https://api-harmony-teach.itheima.net/hm/question/list?${paramsStr}`
    // const res = await req.request(url, {
    //   expectDataType: http.HttpDataType.OBJECT
    // })
    // const result = res.result as Res<PageData<InterviewItem>>
    const data = await httpClient.request<PageData<InterviewItem>>('question/list', http.RequestMethod.GET, this.params)
    this.list = data.rows
    this.isRefreshing = false

    if (this.params.page >= data.pageTotal) {
      this.isFinished = true
    } else {
      this.isFinished = false
      this.isLoading = false
    }
    promptAction.showToast({ message: '更新成功' })
  }

  async LoadData () {
    this.isLoading = true
    // const req = http.createHttp()
    // const paramKeys: string[] = Object.keys(this.params)
    // const paramValues: (number | string | boolean)[] = Object.values(this.params)
    // const paramsStr = paramKeys.map((key,i) => `${key}=${paramValues[i]}`).join('&')
    // const url = `https://api-harmony-teach.itheima.net/hm/question/list?${paramsStr}`
    // const res = await req.request(url, {
    //   expectDataType: http.HttpDataType.OBJECT
    // })
    // const result = res.result as Res<PageData<InterviewItem>>

    const data = await httpClient.request<PageData<InterviewItem>>('question/list', http.RequestMethod.GET, this.params)
    this.list.push(...data.rows)
    this.isLoading = false
    if (this.params.page >= data.pageTotal) {
      this.isFinished = true
    } else {
      this.params.page ++
    }
  }
}
