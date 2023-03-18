import {MatchDetail} from './match-detail.model'

export interface MatchDetailResponse {
    messageCode: string;
    message: string;
    match: MatchDetail;
}

export class MatchDetailResponse implements MatchDetailResponse {
    constructor(
        messageCode: string,
        message: string,
        match: MatchDetail
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.match = match;
    }
}