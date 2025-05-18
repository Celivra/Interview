import { http } from '@kit.NetworkKit';
import { Res } from '../models';
import { auth } from './Auth';

export class HttpClient{
  request<T>(url:string, method:http.RequestMethod, data?:Object){
    const httpInstance = http.createHttp()
    const options:http.HttpRequestOptions = {
      method:method,
      header:{
        'Content-Type':'application/json'
      },
      expectDataType:http.HttpDataType.OBJECT
    }
    let fullUrl = `https://api-harmony-teach.itheima.net/hm/${url}`
    if(method === http.RequestMethod.GET && data){
      const paramKeys: string[] = Object.keys(data)
      const paramValues: (number | string | boolean)[] = Object.values(data)
      const paramsStr = paramKeys.map((key,i) => `${key}=${paramValues[i]}`).join('&')
      fullUrl+=`?${paramsStr}`
    }else {
      options.extraData = data
    }
    const user = auth.getUser()
    if (user.token && options.header) {
      options.header['Authorization'] = `Bearer ${user.token}`
    }
    return httpInstance.request(fullUrl, options)
      .then(res=>{
        const result = res.result as Res<T>
        if(result.code === 10000){
          return result.data
        }
        return Promise.reject(result)
      })
      .catch((e:Error)=>{
        return Promise.reject(e)
      })
      .finally(()=>{
        httpInstance.destroy()
      })
  }
}
export const httpClient = new HttpClient()