
@Component
export struct ProjectPage{
  @StorageProp('topHeight') topHeight: number = 0
  @Builder
  projectCard(h:number){
    Row(){
      Column(){
        Text('Project Name')
          .fontSize(20)
          .fontWeight(2)
        Text('Project content')
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
  j:number[] = [1,2,3,4]
  build() {
    Column(){
      Row({space:5}){
        ForEach(this.i, (i:number)=>{
          Column({space:5}){
            ForEach(this.j, (j:number)=>{
              this.projectCard(((j+i)%2+1))
            })
          }
        })
      }
    }
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .padding({ left: 15, right: 15, top: this.topHeight+5 })
  }
}