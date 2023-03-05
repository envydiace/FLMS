import { Request } from "./request.model";

export interface RequestListResponse {
    messageCode: string,
    message: string,
    requests: Request[];
}

export class RequestListResponse implements RequestListResponse {
    constructor(
        messageCode: string,
        message: string,
        requests: Request[]
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.requests = requests;
    }
}