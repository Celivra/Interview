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