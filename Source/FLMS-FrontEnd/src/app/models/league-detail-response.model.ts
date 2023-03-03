import { LeagueDetail } from './league-detail.model';

export interface LeagueDetailResponse {
    messageCode: string;
    message: string;
    leagueInfo: LeagueDetail;
}

export class LeagueDetailResponse implements LeagueDetailResponse {
    constructor(
        messageCode: string,
        message: string,
        leagueInfo: LeagueDetail
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.leagueInfo = leagueInfo
    }
}