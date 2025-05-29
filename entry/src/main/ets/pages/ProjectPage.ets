interface project{
  ProjectName:string,
  ProjectContent:string;
}

@Component
export struct ProjectPage{
  projectList:project[] = [
    {
      'ProjectName':'Project A',
      'ProjectContent':'A Content'
    },
    {
      'ProjectName':'Project B',
      'ProjectContent':'B Content'
    },
    {
      'ProjectName':'Project C',
      'ProjectContent':'C Content'
    },
    {
      'ProjectName':'Project D',
      'ProjectContent':'D Content'
    },
    {
      'ProjectName':'Project E',
      'ProjectContent':'E Content'
    },
    {
      'ProjectName':'Project F',
      'ProjectContent':'F Content'
    },
  ]
  @StorageProp('topHeight') topHeight: number = 0
  @Builder
  projectCard(name:string, content:string, h:number){
    Row(){
      Column(){
        Text(name)
          .fontSize(20)
          .fontWeight(2)
        Text(content)
          .fontSize(14)
      }
      .justifyContent(FlexAlign.Center)
      .width('50%')
      .height((160*h))
      .border({
        width:1,
        color:0xbbbbbb,
        radius:15
      })
    }
  }
  i:number[] = [1,2]
  flag:boolean = true;
  build() {
    List({ space: 5 }) {
      ListItem() { // 必须用 ListItem 包裹
        Row({ space: 5 }) {
          ForEach(this.i, (i: number) => {
            Column({ space: 5 }) {
              // 筛选奇数或偶数索引的项
              ForEach(
                this.projectList.filter((_, index) =>
                i === 1 ? index % 2 === 0 : index % 2 === 1
                ),
                (item: project) => {
                  this.projectCard(item.ProjectName, item.ProjectContent, ((i + this.projectList.indexOf(item)) % 2 + 1))
                }
              )
            }
          })
        }
        .width('100%') // Row 占满宽度
      }
    }
    .listDirection(Axis.Vertical) // 默认纵向滚动
    .width('100%')
    .height('100%')
    .padding({ left: 15, right: 15, top: this.topHeight + 5 }) // 保留 padding
  }
}