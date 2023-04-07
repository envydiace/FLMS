import { ClubDetail, GetUpdateClubDetail } from './club-detail.model';

export interface ClubDetailResponse {
    messageCode: number;
    message: number;
    clubInfo: ClubDetail;
}

export class ClubDetailResponse implements ClubDetailResponse {
    constructor(
        messageCode: number,
        message: number,
        clubInfo: ClubDetail,
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.clubInfo = clubInfo;
    }
}

export interface UpdateClubDetailResponse {
    messageCode: number;
    message: number;
    info: GetUpdateClubDetail;

}
export class UpdateClubDetailResponse implements UpdateClubDetailResponse {
    constructor(
        messageCode: number,
        message: number,
        info: GetUpdateClubDetail,

    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.info = info;
    }

}

