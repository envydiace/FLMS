import { FeeDetail } from "./fee-detail.model";


export interface LeagueFeeResponse{
    messageCode: string,
    message: string,
    plan: FeeDetail[],
    actual: FeeDetail[],
}

export class LeagueFeeResponse implements LeagueFeeResponse{
    constructor(
        messageCode: string,
        message: string,
        plan: FeeDetail[],
        actual: FeeDetail[],
    ){
        this.messageCode = messageCode;
        this.message = message;
        this.plan = plan;
        this.actual = actual;
    }
}
