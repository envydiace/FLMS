import { ClubDetail } from './club-detail.model';

export interface ClubDetailResponse {
    messageCode: number;
    message:number;
    clubInfo: ClubDetail;
}

export class ClubDetailResponse implements ClubDetailResponse {
    constructor(
        messageCode: number,
        message:number,
        clubInfo: ClubDetail,
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.clubInfo = clubInfo;
    }
}

