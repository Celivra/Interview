import { http } from '@kit.NetworkKit';
import { Queue } from '@kit.ArkTS';
import { Res } from '../models';

class HttpClient{
  request<T>(url:string, method:http.RequestMethod, data:Object){
    const httpInstance = http.createHttp()
    const options:http.HttpRequestOptions = {
      method:method,
      header:{
        'Content-Type':'application/json'
      },
      expectDataType:http.HttpDataType.OBJECT
    }
    let fullUrl = `https://api-harmony-teach.itheima.net/hm/${url}`
    if(method === http.RequestMethod.GET){
      const paramKeys: string[] = Object.keys(data)
      const paramValues: (number | string | boolean)[] = Object.values(data)
      const paramsStr = paramKeys.map((key,i) => `${key}=${paramValues[i]}`).join('&')
      fullUrl+=`?${paramsStr}`
    }else {
      options.extraData = data
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