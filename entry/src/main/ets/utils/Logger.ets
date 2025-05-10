import { hilog } from '@kit.PerformanceAnalysisKit';
class Logger {
  private domain: number;
  private tag: string;
  private format: string = '%{public}s→ %{public}s';
  constructor(domain: number = 0x0000, tag: string = '') {
    this.domain = domain;
    this.tag = tag;
  }
  debug(...args: string[]): void {
    hilog.debug(this.domain, this.tag, this.format, args);
  }
  info(...args: string[]): void {
    hilog.info(this.domain, this.tag, this.format, args);
  }
  warn(...args: string[]): void {
    hilog.warn(this.domain, this.tag, this.format, args);
  }
  error(...args: string[]): void {
    hilog.error(this.domain, this.tag, this.format, args);
  }
}
export const logger =  new Logger(0x1234, 'interview_experience_logger');
