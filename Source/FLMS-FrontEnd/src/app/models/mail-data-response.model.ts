import { MailData } from "./mail-data.model";

export interface MailDataResponse {
    messageCode: string,
    message: string,
    messageMailCode: string,
    mailMessage: string,
   
}

export class MailDataResponse implements MailDataResponse{
constructor(
    messageCode: string,
    message: string,
    messageMailCode: string,
    mailMessage: string,
   
){
    this.messageCode = messageCode,
    this.message = message,
    this.messageMailCode = messageMailCode,
    this.mailMessage = mailMessage
   
}

}