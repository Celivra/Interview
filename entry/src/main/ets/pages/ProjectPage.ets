interface project {
  ProjectName: string,
  ProjectContent: string;
}

@Component
export struct ProjectPage {
  projectList: project[] = [
    {
      'ProjectName': 'Project A',
      'ProjectContent': 'A Content'
    },
    {
      'ProjectName': 'Project B',
      'ProjectContent': 'B Content'
    },
    {
      'ProjectName': 'Project C',
      'ProjectContent': 'C Content'
    },
    {
      'ProjectName': 'Project D',
      'ProjectContent': 'D Content'
    },
    {
      'ProjectName': 'Project E',
      'ProjectContent': 'E Content'
    },
    {
      'ProjectName': 'Project F',
      'ProjectContent': 'F Content'
    },
  ]

  @StorageProp('topHeight') topHeight: number = 0

  @Builder
  projectCard(name: string, content: string) {
    Column() {
      Text(name)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .margin({ bottom: 8 })
        .fontColor('#333333')

      Text(content)
        .fontSize(14)
        .textAlign(TextAlign.Center)
        .fontColor('#666666')
        .margin({ bottom: 12 })
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(160)
    .padding(15)
    .border({ width: 1, color: '#E0E0E0', radius: 12 })
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 4, color: '#10000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      Grid() {
        ForEach(this.projectList, (item: project) => {
          GridItem() {
            this.projectCard(item.ProjectName, item.ProjectContent)
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16, top: this.topHeight + 16 })
    .backgroundColor('#F5F5F5')
  }
}