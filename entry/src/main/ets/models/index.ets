export interface Res<T> {
  code: number
  message: string
  data: T
}

export interface User {
  id: string
  username: string
  avatar: string
  token: string
  nickName?: string
  // 学习时长
  totalTime?: number
  // 打卡次数
  clockinNumbers?: number
}

export interface InterviewItem {
  id: string
  stem: string
  content: string
  likeCount: number
  views: number
  creatorName: string
  creatorAvatar: ResourceStr
  createdAt: string
  stage: string[]
  likeFlag: 0 | 1
  collectFlag: 0 | 1
}
export interface InterviewListParams {
  questionBankType: 9 | 10
  page: number
  sort: 30 | 0
  keyword: string
}
export interface PageData<T> {
  total: number,
  pageTotal: number
  rows: T[]
}