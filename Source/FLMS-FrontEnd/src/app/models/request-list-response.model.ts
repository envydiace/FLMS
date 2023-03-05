import { Request } from "./request.model";

export interface RequestListResponse {
    requests: Request[];
}

export class RequestListResponse implements RequestListResponse {
    constructor(
        requests123: Request[]
    ) {
        this.requests = requests123;
    }
}